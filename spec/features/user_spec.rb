require 'rails_helper'

def log_in
  visit '/u/sign_in'
  fill_in 'Email', with: 'user@example.com'
  fill_in 'Password', with: 'password'
  click_button 'Log in'
end

# pending 'the signup process' do
# end

describe 'the login process' do
  before do
    @user = create(:user)
  end

  it 'signs me in' do
    log_in
    expect(page).to have_content 'Your Dashboard'
  end

  it 'shows the approval pending message if user is not approved' do
    log_in
    expect(page).to have_content 'Your account is awaiting approval.'
  end

  it 'shows the no investments message if user is approved and without investments' do
    @user.update_attribute(:approved, true)
    log_in
    expect(page).to have_content 'No investments'
  end

  it 'shows investments if user is approved and has investments' do
    
  end
end
