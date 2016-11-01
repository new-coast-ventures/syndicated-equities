# ================================================
# RUBY->MODEL->ADDRESS ===========================
# ================================================
# TODO: validators
class Address < ActiveRecord::Base
  belongs_to :user
end
