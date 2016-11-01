require 'rails_helper'

RSpec.describe Form, type: :model do
  it { should belong_to :deal }
  it { should have_attached_file(:document) }
end
