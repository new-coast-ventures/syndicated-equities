require 'rails_helper'

def log_in
  visit '/u/sign_in'
  fill_in 'Email', with: 'user@example.com'
  fill_in 'Password', with: 'password'
  click_button 'Log in'
end

describe 'investment authentication' do
  before do
    @user = create(:user)
    @investment = create(:investment)
    @user.investments.push(@investment)
  end

  it 'shows the investment if the user is properly authenticated' do
    log_in
    visit "/investments/#{@investment.id}"
    expect(page).to have_content(@investment.deal.title)
  end

  it 'does not show the investment if the user is not properly authenticated' do
    log_in
    visit "/investments/#{@investment.id + 1}"
    expect(page).to have_content('Not authorized')
  end
end
