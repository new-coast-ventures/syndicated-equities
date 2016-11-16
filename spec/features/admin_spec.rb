require 'rails_helper'

def log_in
  visit '/u/sign_in'
  fill_in 'Email', with: 'user@example.com'
  fill_in 'Password', with: 'password'
  click_button 'Log in'
end

describe 'note authentication' do
  before(:each) do
    @user = create(:user)
  end

  it 'shows the note if the user is properly authenticated' do
    @user.update_attribute(:admin, true)
    log_in
    visit "/admin"
    expect(page).to have_content('Site Administration')
  end

  it 'does not show the note if the user is not properly authenticated' do
    log_in
    visit "/admin"
    expect(page).to have_content('Not authorized')
  end
end
