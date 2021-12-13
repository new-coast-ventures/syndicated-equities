require "roo"
require "set"

# ================================================
# RUBY->MODEL->INVESTMENT ========================
# ================================================

# t.integer "user_id"
# t.integer "deal_id", null: false
# t.integer "amount_invested"
# t.date "invested_on"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.string "investing_entity"
# t.string "investor_email"
# t.string "investor_first_name"
# t.string "investor_last_name"
# t.integer "amount_cents"
# t.string "amount_currency", default: "USD", null: false
# t.string "investor_entity"
# t.string "gross_distribution"


class Investment < ActiveRecord::Base
  belongs_to :investor, class_name: 'User', foreign_key: :user_id, inverse_of: :investments
  belongs_to :deal, inverse_of: :investors
  has_many :gross_distributions, dependent: :destroy

  validates_presence_of :deal

  default_scope { order(invested_on: :desc) }

  scope :active, -> { joins(:deal).where('deals.closed_at IS NULL') }
  scope :closed, -> { joins(:deal).where('deals.closed_at IS NOT NULL') }

  monetize :amount_cents, allow_nil: true

  def name
    [investor&.name, deal&.title].compact.join(" - ")
  end

  def investor_name
    "#{investor_first_name} #{investor_last_name}"
  end

  def display_date
    deal&.date&.strftime("%m/%d/%y") || "n/a"
  end

  def forms
    deal.forms.to_a + deal.property&.forms.to_a
  end

  def property
    deal.property
  end

  def self.import(property_id, file, mapping)
    puts "import data from file #{file}"
    # create_deals(file, property_id)
    # create_investments(file)
    local_file = "tmp/#{file.split("/")[-1]}"
    user_ids = []
    CSV.foreach(local_file, headers: true) do |row|
      deal = Deal.find_or_create_by(title: row[mapping["investing_entity"]])
      deal.update(property_id: property_id)

      user_id = get_user(row, mapping)
      user_ids << user_id
      investor_hash = {
        deal_id: deal.id,
        investor_last_name: row[mapping["investor_last_name"]],
        investor_first_name: row[mapping["investor_first_name"]],
        investor_email: row[mapping["investor_email"]].downcase,
        investor_alt_email: row[mapping["investor_alt_email"]]&.downcase,
        investing_entity: row[mapping["investing_entity"]],
        investor_entity: row[mapping["investor_entity"]],
        gross_distribution: row[mapping["gross_distribution"]],
        # gross_distribution_percentage: row[mapping["gross_distribution_percentage"]],
        amount_invested: row[mapping["amount_invested"]].strip.delete("$"),
        user_id: user_id
      }

      puts investor_hash

      Investment.create! investor_hash

    rescue => e
      puts "Error on row: #{row}: #{e}"
      next
    end

    UpdateInvestorJob.perform_now(user_ids) if !Rails.env.development?
    UpdatePropertyJob.perform_now(property_id) if !Rails.env.development?
  rescue => e
    puts e.backtrace.join("\n")
    puts e
    # end
  end

  def calc_gross_distribution
    deal.property.gross_distributions.to_i * gross_distribution_percentage.to_f.round(4)
  rescue => e
    return  "N/A"
  end

  def gross_distribution_view
    "#{(gross_distribution_percentage.to_f * 100).round(4) }%"
  end

  def total_gross_distribution(gross_distributions=self.gross_distributions)
    total = 0.00
    gross_distributions.each do |gross|
      total += gross.amount.to_f
    end
    total
  end

  def total_amount_invested_by_investor
    investments = property.investments.where(user_id: @user_id)
    total = 0.00
    investments.each do |inv|
      total += inv.amount_invested.delete(",").to_f
    end
    total
  end

  YEAR_END = 370.days
  def annual_yields_by_year(gross_distributions, user_id)
    @user_id = user_id
    # group distributions in 410 day increments and calculate annual yield
    # Can't do 1.year since some distributions happen a couple days after the year ends
    # Can't do 410.days since some distributions happen a couple days after the year ends

    @yields = []
    year_start_date = self.deal.property.closing_date
    year_end_date = year_start_date + YEAR_END
    collect_yearly_gross_distributions(gross_distributions, year_start_date, year_end_date)
    @yields
  end

  def collect_yearly_gross_distributions(gross_distributions, start_date_, end_date_, index_count=0, year_count=0)
    year_distributions = gross_distributions[index_count..index_count+3]
    # year_distributions = gross_distributions.where("distribution_date >= ? AND distribution_date <= ?", start_date_, end_date_)
    if year_distributions && !year_distributions.empty?
      index_count += 4
      year_count += 1
      @yields << {
        "year": year_count,
        "yield": calculate_annual_yield(year_distributions) * 100
      }
      collect_yearly_gross_distributions(gross_distributions, end_date_ + 2.days, end_date_ + YEAR_END, index_count, year_count)
    end
  end

  def calculate_annual_yield(year_distributions)
    # calculate annual yield
    ((total_gross_distribution(year_distributions).round(2))/(year_distributions.count/4.00))/total_amount_invested_by_investor.round(2)
  end

  private

  def self.create_deals(file, property_id)

    puts "create Deals from file #{file}"
    deals = Set.new

    xlsx = Roo::Spreadsheet.open(file)
    xlsx.each_row_streaming(offset: 1) do |row|
      title = sanitized_string_from(row[0])
      next if title.blank?

      deals << title
      print "."
    end

    # values = deals.to_a.map { |title| "('#{title}', '#{Time.now}', '#{Time.now}', #{property_id})" }.join(",")
    # ActiveRecord::Base.connection.execute("INSERT INTO deals (title, created_at, updated_at, property_id) VALUES #{values}")
    deals.each do |deal|
      Deal.where(title: deal, property_id: property_id).first_or_create
    end
    Deal.pluck(:id, :title).map { |d| @deals[d[1]] = d[0] }
  end

  def self.sanitized_int_from(key)
    key&.value || 0
  end

  def self.sanitized_string_from(key)
    (key&.value || "").to_s.strip.gsub("'", %q(\\\'))
  end

  def self.get_user(row, mapping)
    first_name = row[mapping["investor_first_name"]]&.strip
    last_name = row[mapping["investor_last_name"]]&.strip
    email = row[mapping["investor_email"]].downcase&.strip ? row[mapping["investor_email"]]&.downcase&.strip : "#{first_name}_#{last_name}#{rand(1000)}@syndicatedequities.com"
    alt_email = row[mapping["investor_alt_email"]]&.strip
    user = User.find_by(email: email&.downcase)
    if !user
      user = User.create(
        email: email&.downcase,
        password: "Se1#{SecureRandom.base64(8)}",
        first_name: first_name,
        last_name: last_name,
        email_2: alt_email
      )
    end

    user.id
  rescue => e
    puts "[get_user]ERROR for #{email}: #{e}"
  end

  def self.create_temp_csv(file)
    FileUtils.cp(file, "tmp/")
  end

  def self.combine_investments(user_id, order, status)
    user_investments =
      Investment
                .where(user_id: user_id)
                .or(Investment.where(view_users: user_id.to_s))
                .joins(deal: :property)
                .order("properties.closing_date #{order}")

    if status != 'all'
      user_investments = user_investments.where("properties.status = ?", status)
    end

    investments = {}
    property_ids = []
    user_investments.each do |investment|
      property = investment&.deal&.property
      if investments[property.id].nil?
        property_ids << property.id
        investments[property.id] = {
          type: property.property_type&.humanize&.titleize,
          closing_date: property&.closing_date&.strftime("%m/%d/%Y"),
          investor_equity: investment&.amount_invested,
          gross_distribution: property.total_user_gross_distribution(user_id),
          property_id: property&.id,
          investment_id: investment.id,
          property_img: property&.avatar,
          property_nickname: property&.nickname,
          address: "#{property.address.line1}, #{property.address.location}",
          status: property.status
        }
      else
        investments[property.id][:investor_equity] = ( investments[property.id][:investor_equity].delete(",").to_f + investment.amount_invested.delete(",").to_f)
        investments[property.id][:gross_distribution] += investment.gross_distribution.to_i
      end
    end

    total_investor_equity = 0
    investments.each {|invs| total_investor_equity += invs[1][:investor_equity].to_f}

    total_gross_distribution = 0
    investments.each {|invs| total_gross_distribution += invs[1][:gross_distribution].to_f}

    {investments: investments,  property_ids: property_ids, total_investor_equity: total_investor_equity, total_gross_distribution: total_gross_distribution}
  end

  def self.active_investments(user_id, status)

    all_investments =
      Investment
                .where(user_id: user_id)
                .or(Investment.where(view_users: user_id.to_s))
                .joins(deal: :property)

    if status != 'all'
      all_investments = all_investments.where("properties.status = ?", status)
    end

    all_investments
  end
end
