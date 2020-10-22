# t.string "name"
# t.datetime "closing_date"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.string "nickname"
# t.string "status"
# t.datetime "sale_date"
# t.string "gross_distributions"
# t.string "internal_rate_of_return"
# t.string "equity_multiple"
# t.string "property_type"
# t.text "description"
# t.string "funding_amount"
# t.string "target_irr"
# t.string "average_annual_return"

class Property < ActiveRecord::Base
  has_one_attached :avatar

  include Filterable
  
  attr_accessor :potential_investment_amount, :investment_entity

  has_one  :address, as: :addressable, dependent: :destroy
  has_many :forms, dependent: :destroy
  has_many :deals
  has_many :notes
  has_many :investments, through: :deals

  PROPERTY_TYPE_OPTIONS = {government: 'government', hospitality: 'hospitality', industrial: 'industrial', medical: 'medical', multifamily: 'multifamily', office: 'office', parking: 'parking', retail: 'retail', student_housing: 'student housing', self_storage: 'self-storage'}


  validates :avatar, content_type: ['image/png', 'image/jpg', 'image/jpeg']

  def deal_equity
    return "0.00" if self.deals.nil?
    self&.investments.pluck(:amount_invested)&.sum
  end

  def self.search(search)
    where("name LIKE ?", "%#{search}%").or(where("nickname LIKE ?", "%#{search}%"))
  end

  def self.filter(search)
    if search == "all"
      Property.all
    else
      where("status LIKE ?", "%#{search}%") 
    end
  end

  def list_name
    self.nickname ? self.nickname : self.name
  end

  def total_gross_distribution
    total = 0
    self.investments.pluck(:gross_distribution).each do |gross|
      total += gross.to_i
    end
    total
  end

  def total_investor_gross_distributions
    total = 0
    investments.each do |inv|
      inv.gross_distributions.each do |gross|
        total += gross.amount.to_f
      end
    end
    total.round(2)
  end

  def total_user_gross_distribution(user_id)
    total = 0
    self.investments.where(user_id: user_id).each do |inv|
      inv.gross_distributions.each do |gross|
        total += gross.amount.to_i
      end
    end
    total
  end

  def return_on_equity
    begin
      if !self.gross_distributions.blank? && !self.equity_multiple.blank?
        (self.gross_distributions.to_i / deal_equity.to_f).round(4).to_d * 100
      else
        nil
      end
    rescue => e 
      puts e
      nil
    end
  end
end
