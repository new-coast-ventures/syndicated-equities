# ================================================
# RUBY->MODEL->INVESTMENT ========================
# ================================================
class Investment < ActiveRecord::Base
  belongs_to :investor, class_name: 'User', foreign_key: :user_id, inverse_of: :investments
  belongs_to :deal, inverse_of: :investors

  validates_presence_of :deal

  default_scope { order(invested_on: :desc) }

  scope :active, -> { joins(:deal).where('deals.closed_at IS NULL') }
  scope :closed, -> { joins(:deal).where('deals.closed_at IS NOT NULL') }

  def name
    [investor&.name, deal&.title].compact.join(" - ")
  end

  def display_date
    deal&.date&.strftime("%m/%d/%y") || "n/a"
  end
end
