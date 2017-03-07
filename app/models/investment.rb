# ================================================
# RUBY->MODEL->INVESTMENT ========================
# ================================================
class Investment < ActiveRecord::Base
  belongs_to :investor, class_name: 'User', foreign_key: :user_id, inverse_of: :investments
  belongs_to :deal, inverse_of: :investors

  validates_presence_of :deal
  validates_presence_of :amount_invested
  validates_presence_of :invested_on

  default_scope { order(invested_on: :desc) }

  scope :active, -> { joins(:deal).where('deals.closed_at IS NULL') }
  scope :closed, -> { joins(:deal).where('deals.closed_at IS NOT NULL') }

  def name
    [investor.try(:name), deal.try(:title)].compact.join(" - ")
  end

  def display_date
    (invested_on > 100.years.ago) ? invested_on.strftime("%m/%d/%y") : "n/a"
  end
end
