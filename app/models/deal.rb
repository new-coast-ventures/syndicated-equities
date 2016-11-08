# ================================================
# RUBY->MODEL->DEAL ==============================
# ================================================
class Deal < ActiveRecord::Base
  has_many :investments, inverse_of: :deal
  has_many :investors, through: :investments, inverse_of: :investments
  has_many :notes, inverse_of: :deal
  has_many :forms, inverse_of: :deal

  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :date
end
