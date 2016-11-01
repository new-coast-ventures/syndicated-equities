# ================================================
# RUBY->MODEL->INVESTMENT ========================
# ================================================
class Note < ActiveRecord::Base
  belongs_to :deal
end
