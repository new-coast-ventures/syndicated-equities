# ================================================
# RUBY->MODEL->FORM ==============================
# ================================================
class Form < ActiveRecord::Base
  # belongs_to :owner, polymorphic: true
  belongs_to :property
  
  has_one_attached :document

  validates_presence_of :title
  validates_presence_of :document
  validates :document, content_type: ['application/pdf','application/msword','	application/vnd.openxmlformats-officedocument.wordprocessingml.document']
end
