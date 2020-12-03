# ================================================
# RUBY->MODEL->USER ==============================
# ================================================
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one  :address, as: :addressable, dependent: :destroy
  has_many :investments, inverse_of: :investor
  has_many :gross_distributions, through: :investments
  has_many :deals, through: :investments, inverse_of: :investors

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email
  validate :password_complexity

  accepts_nested_attributes_for :address
  
  after_create :send_admin_email
  # before_save :check_for_email_update
  before_save :check_for_updates

  def password_complexity
    if password.present?
      if !password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)/)
        errors.add :password, "must contain at least one uppercase letter, one lowercase letter, and one number"
      end
    end
  end

  def self.search(query)
    where("first_name LIKE ?", "%#{query}%").or(where("last_name LIKE ?", "%#{query}%"))
  end

  def name
    [first_name.to_s, last_name.to_s].compact.join(" ").strip
  end

  def investment_entity
    investments.pluck(:investing_entity).uniq.join(", <br>").html_safe
  end

  def investor_entity
    investments.pluck(:investor_entity).uniq.join(", <br>").html_safe
  end

  def total_invested
    total = 0
    investments.each do |inv|
      total += inv.amount_invested.delete(",").to_f
    end
    total.round(2)
  end

  def total_distributions
    # gross_distributions.inject(0) { |sum, i| sum + i.amount.to_f }
    total = 0
    investments.each do |inv|
      inv.gross_distributions.each do |gross|
        total += gross.amount.delete(",").to_f
      end
    end
    total.round(2)
  end

  def total_properties
    deals.pluck(:property_id).uniq.compact.count
  end

  def investment_properties
    prop_ids = deals.pluck(:property_id).uniq.compact
    Property.where(id: prop_ids)
  end

  def self.insert_with(attributes = {})
    User.find_by(attributes.slice(:first_name, :last_name, :email)) || User.create(attributes)
  end

  def total_investments
    investments.count
  end

  def send_admin_email
    AdminMailer.new_user_sign_up(self).deliver_now
  end

  def check_for_updates
    if self.email_changed? || self.first_name_changed? || self.last_name_changed? || self.address_1_changed? || self.address_2_changed? || self.city_changed? || self.state_changed? || self.country_changed? || self.zip_code_changed? 
      AdminMailer.user_fields_changed(self, self.changes).deliver_now
    end
  end

  def check_for_email_update
    if self.email_changed? 
      AdminMailer.user_email_changed(self, self.changes['email'][0]).deliver_now
    end
  end

end