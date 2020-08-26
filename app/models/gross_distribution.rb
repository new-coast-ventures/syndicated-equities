# t.bigint "investment_id"
# t.string "amount"
# t.string "distribution_date"
# t.string "description"

require 'roo'
class GrossDistribution < ActiveRecord::Base
  belongs_to :investment
  validates :distribution_date, uniqueness: { scope: :investment_id }

  attr_reader :investor_entity, :investor_email
  private
  def self.create_temp_xlsx(file)
    FileUtils.cp(file, "tmp")
  end

  def self.pull_headers(file)
    headers = []
    Roo::Spreadsheet.open(file).sheet(0).row(1).each do |head|
      headers << [head, head] unless head.nil?
    end 
    headers << ['No Mapping', nil]
    headers
  end

  def self.create_import_hash(file, mapping)
     # Loop through .xlsx doc
     import_file = file.split("/")[-1]
     local_file = "tmp/#{import_file}"
     xlsx = Roo::Spreadsheet.open(local_file)
     sheet = xlsx.sheet(0)
     gd_hash = sheet.parse(email: mapping["investor_email"], investor_entity: mapping["investor_entity"], amount: mapping["amount"], date: mapping["distribution_date"], clean:true)

     File.delete(local_file) if File.exist?(local_file)

     gd_hash.to_json
  end

  def self.import(property_id, file, mapping)
    # Loop through .xlsx doc
    import_file = file.split("/")[-1]
    local_file = "tmp/#{params[:import_file].split("/")[-1]}"

    xlsx = Roo::Spreadsheet.open(local_file)
    sheet = xlsx.sheet(0)
    gd_hash = sheet.parse(email: mapping["investor_email"], investor_entity: mapping["investor_entity"], amount: mapping["amount"], date: mapping["distribution_date"], clean:true)
   
    prop = Property.find(property_id)
   
    investments = prop.investments
   
    invalid_entities = []
    invalid_emails = []
    
    gd_hash.each do |row|
      if investments.where(investor_email: row[:email]).blank?
        invalid_emails << row[:email] unless (invalid_emails.include?(row[:email]) || row[:email].nil?)
      end

      investment = investments.where(investor_email: row[:email], investor_entity: row[:investor_entity])
      
      if !investment.blank?
        create(
          investment_id: investment.first.id,
          amount: row[:amount],
          distribution_date: row[:date],
          description: row[:investor_entity]
        )
      else
        invalid_entities << row[:investor_entity] unless (invalid_entities.include?(row[:investor_entity]) || row[:investor_entity].nil?)
      end
    end
      
    {invalid_entities: invalid_entities, invalid_emails: invalid_emails}
  rescue => e
    puts e.backtrace.join("\n")
    puts e
    # end
  end
end
