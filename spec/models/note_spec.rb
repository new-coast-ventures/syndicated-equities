require 'rails_helper'

RSpec.describe Note, type: :model do
  it { should belong_to :deal }
end
