class Property < ActiveRecord::Base
  has_one  :address, as: :addressable, dependent: :destroy
  has_many :forms, as: :owner, dependent: :destroy
  has_many :deals
end
