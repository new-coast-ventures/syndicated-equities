# ================================================
# RUBY->MODEL->INVESTMENT ========================
# ================================================
class Investment < ActiveRecord::Base
  belongs_to :investor, class_name: 'User', foreign_key: :user_id
  belongs_to :deal

  validates_presence_of :investor
  validates_presence_of :deal
  validates_presence_of :amount_invested
  validates_presence_of :invested_on
end
