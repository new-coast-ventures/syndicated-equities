# ================================================
# RUBY->MODEL->INVESTMENT ========================
# ================================================
class Investment < ActiveRecord::Base
  belongs_to :user
  belongs_to :deal
end
