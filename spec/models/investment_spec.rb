# ================================================
# RUBY->TEST->INVESTMENTSPEC =====================
# ================================================
require 'rails_helper'

RSpec.describe Investment, type: :model do
  it { should belong_to(:investor).class_name('User') }
  it { should belong_to(:deal) }
end
