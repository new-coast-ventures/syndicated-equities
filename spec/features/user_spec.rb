require 'rails_helper'


describe 'the login process' do
  before :each do
    @user = create(:user)
  end

  it 'signs me in' do
    visit '/u/sign_in'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    expect(page).to have_content 'Your Dashboard'
  end
end
