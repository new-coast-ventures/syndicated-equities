class Property < ActiveRecord::Base
  has_one_attached :avatar

  include Filterable

  has_one  :address, as: :addressable, dependent: :destroy
  has_many :forms, as: :owner, dependent: :destroy
  has_many :deals
  has_many :investments, through: :deals


  validates :avatar, content_type: ['image/png', 'image/jpg', 'image/jpeg'],
  dimension: { width: { min: 600 },
               rsheight: { min: 600 }, message: 'is not 600 x 600 or above' }

  def deal_equity
    return "0.00" if self.deals.nil?
    self&.investments.pluck(:amount_invested).sum
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

  def return_on_equity
    begin
      if !self.gross_distributions.blank? && !self.equity_multiple.blank?
        self.gross_distributions.to_f / self.equity_multiple.to_f
      else
        nil
      end
    rescue => e 
      puts e
      nil
    end
  end
end
