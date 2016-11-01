# ================================================
# RUBY->TEST->DEALSPEC ===========================
# ================================================
require 'rails_helper'

RSpec.describe Deal, type: :model do
  it { should have_many(:investments) }
  it { should have_many(:investors) }
  it { should have_many(:notes) }
  it { should have_many(:forms) }
end
