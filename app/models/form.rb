# ================================================
# RUBY->MODEL->FORM ==============================
# ================================================
class Form < ActiveRecord::Base
  include RailsSortable::Model
  set_sortable :sort  # Indicate a sort column
  # belongs_to :owner, polymorphic: true
  belongs_to :property, optional: true
  
  has_one_attached :document

  validates_presence_of :title
  validates_presence_of :document
  # validates :document, content_type: ['application/pdf','application/msword','	application/vnd.openxmlformats-officedocument.wordprocessingml.document']
end
