# ================================================
# RUBY->MODEL->FORM ==============================
# ================================================
class Form < ActiveRecord::Base
  belongs_to :owner, polymorphic: true
  
  has_attached_file :document

  validates_presence_of :title
  validates_presence_of :document
  validates_attachment :document, presence: true
  validates_attachment_content_type :document, content_type: ['application/pdf','application/msword','	application/vnd.openxmlformats-officedocument.wordprocessingml.document']
end
