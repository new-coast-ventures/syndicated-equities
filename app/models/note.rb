# ================================================
# RUBY->MODEL->INVESTMENT ========================
# ================================================
class Note < ActiveRecord::Base
  belongs_to :deal

  validates_presence_of :deal
  validates_presence_of :title
  validates_presence_of :content

  def self.global
    where(global: true).order(created_at: :desc)
  end
end
