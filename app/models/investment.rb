# ================================================
# RUBY->MODEL->INVESTMENT ========================
# ================================================
class Investment < ActiveRecord::Base
  belongs_to :investor, class_name: 'User', foreign_key: :user_id
  belongs_to :deal
end
