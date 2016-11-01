# ================================================
# RUBY->MODEL->DEAL ==============================
# ================================================
# TODO: validators
class Deal < ActiveRecord::Base
  has_many :investments
  has_many :investors, through: :investments
  has_many :notes
  has_many :forms
end
