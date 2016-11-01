require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:investments) }
  it { should have_many(:addresses) }
  it { should have_many(:deals) }
end
