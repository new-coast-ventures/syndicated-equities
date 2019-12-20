# ================================================
# RUBY->MODEL->INVESTMENT ========================
# ================================================
class Note < ActiveRecord::Base
  # belongs_to :deal
  belongs_to :property
  
  # has_attached_file :document

  # validates_presence_of :deal
  # validates_presence_of :property
  validates_presence_of :title
  validates_presence_of :content
  # validates_attachment_content_type :document, content_type: ['application/pdf','application/msword','	application/vnd.openxmlformats-officedocument.wordprocessingml.document']

  def self.global
    where(global: true).order(created_at: :desc)
  end
end
