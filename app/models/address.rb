# ================================================
# RUBY->MODEL->ADDRESS ===========================
# ================================================
class Address < ActiveRecord::Base
  belongs_to :user, inverse_of: :address

  validates_presence_of :line1
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip

  def name
    line1 + ' ' + city + ', ' + state + ' ' + zip
  end
end
