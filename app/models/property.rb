class Property < ActiveRecord::Base
  has_one  :address, as: :addressable, dependent: :destroy
  has_many :forms, as: :owner, dependent: :destroy
  has_many :deals


  def deal_equity
    return "0.00" if self.deals.nil?
    self&.deals&.first&.investments.pluck(:amount_invested).sum
  end
end
