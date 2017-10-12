# ================================================
# RUBY->MODEL->DEAL ==============================
# ================================================
class Deal < ActiveRecord::Base
  belongs_to :property
  has_many :investments, inverse_of: :deal
  has_many :investors, through: :investments, inverse_of: :investments
  has_many :notes, inverse_of: :deal
  has_many :forms, as: :owner, dependent: :destroy

  validates_presence_of :title
end
