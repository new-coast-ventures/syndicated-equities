require 'rails_helper'

RSpec.describe Investment, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:deal) }
end
