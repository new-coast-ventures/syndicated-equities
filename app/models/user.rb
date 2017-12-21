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
  has_many :deals, through: :investments, inverse_of: :investors

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email
  validate :password_complexity

  accepts_nested_attributes_for :address

  def password_complexity
    if password.present?
      if !password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)/)
        errors.add :password, "must contain at least one uppercase letter, one lowercase letter, and one number"
      end
    end
  end

  def name
    [first_name.to_s, last_name.to_s].compact.join(" ")
  end

  def total_invested
    return investments.first.amount_invested if investments.count == 1
    investments.inject(0) { |sum, i| sum + i.amount_invested }
  end

  def self.insert_with(attributes = {})
    User.find_by(attributes.slice(:first_name, :last_name, :email)) || User.create(attributes)
  end

end