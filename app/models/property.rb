class Property < ActiveRecord::Base
  has_one_attached :avatar

  include Filterable

  has_one  :address, as: :addressable, dependent: :destroy
  has_many :forms, as: :owner, dependent: :destroy
  has_many :deals

  attr_accessor :sale_date

  validates :avatar, content_type: ['image/png', 'image/jpg', 'image/jpeg'],
  dimension: { width: { min: 600 },
               rsheight: { min: 600 }, message: 'is not 600 x 600 or above' }

  def deal_equity
    return "0.00" if self.deals.nil?
    self&.deals&.first&.investments&.pluck(:amount_invested)&.sum
  end

  def self.search(search)
    where("name LIKE ?", "%#{search}%").or(where("nickname LIKE ?", "%#{search}%"))
  end

  def self.filter(search)
    where("status LIKE ?", "%#{search}%") 
  end
end
