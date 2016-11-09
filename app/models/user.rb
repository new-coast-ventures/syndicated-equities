# ================================================
# RUBY->MODEL->USER ==============================
# ================================================
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :address, inverse_of: :user
  has_many :investments, inverse_of: :investor
  has_many :deals, through: :investments, inverse_of: :investors

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email

  accepts_nested_attributes_for :address

  def name
    first_name.to_s + ' ' + last_name.to_s
  end
end
