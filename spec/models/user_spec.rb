# ================================================
# RUBY->TEST->USERSPEC ===========================
# ================================================
require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = create(:user)
    @investment1 = create(:investment)
    @investment2 = create(:investment)
    @user.investments = [@investment1, @investment2]
  end

  it { should have_many(:investments) }
  it { should have_one(:address) }
  it { should have_many(:deals) }

  it 'has a total_invested method that returns the total invested' do
    expect(@user.total_invested).to eq(@investment1.amount_invested + @investment2.amount_invested)
  end

  it 'has a investments_sorted_by_date method that returns the investments sorted in descending order by date' do
    @investment2.invested_on = Date.today
    @investment2.save!
    expect(@user.investments_sorted_by_date).to eq([@investment2, @investment1])
  end

end
