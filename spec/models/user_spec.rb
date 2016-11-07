# ================================================
# RUBY->TEST->USERSPEC ===========================
# ================================================
require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:investments) }
  it { should have_one(:address) }
  it { should have_many(:deals) }
end
