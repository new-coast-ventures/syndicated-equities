# ================================================
# RUBY->MODEL->FORM ==============================
# ================================================
class Form < ActiveRecord::Base
  belongs_to :deal
  has_attached_file :document

  validates_presence_of :deal
  validates_presence_of :title
  validates_presence_of :document
  validates_attachment :document, presence: true
end
