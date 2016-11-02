# ================================================
# RUBY->MODEL->DEAL ==============================
# ================================================
class Deal < ActiveRecord::Base
  has_many :investments
  has_many :investors, through: :investments
  has_many :notes
  has_many :forms

  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :date
end
