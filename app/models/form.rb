class Form < ActiveRecord::Base
  belongs_to :deal
  has_attached_file :document
end
