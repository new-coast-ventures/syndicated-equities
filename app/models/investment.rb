# ================================================
# RUBY->MODEL->INVESTMENT ========================
# ================================================
class Investment < ActiveRecord::Base
  belongs_to :investor, class_name: 'User', foreign_key: :user_id, inverse_of: :investments
  belongs_to :deal, inverse_of: :investors

  validates_presence_of :deal
  validates_presence_of :amount_invested
  validates_presence_of :invested_on

  def name
    (investor ? investor.name : '') + ' - ' + (deal ? deal.title : '')
  end
end
