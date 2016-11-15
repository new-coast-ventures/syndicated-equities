# ================================================
# RUBY->TEST->INVESTMENTSPEC =====================
# ================================================
require 'rails_helper'

RSpec.describe Investment, type: :model do
  before do
    @investment = create(:investment)
    @user = create(:user)
    @investment.investor = @user
    @investment.save!
  end

  it { should belong_to(:investor).class_name('User') }
  it { should belong_to(:deal) }

  it 'has a name method that returns the investor name and the deal' do
    expect(@investment.name).to eq (@investment.investor.name + ' - ' + @investment.deal.title)
  end
end
