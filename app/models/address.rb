# ================================================
# RUBY->MODEL->ADDRESS ===========================
# ================================================
class Address < ActiveRecord::Base
  belongs_to :addressable, polymorphic: true

  validates_presence_of :line1
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip

  def name
    %w(line1 city state zip).join(", ")
  end

  def location
    "#{self.city}, #{self.state}, #{self.zip}"
  end
end
