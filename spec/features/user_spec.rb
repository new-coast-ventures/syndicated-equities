require 'rails_helper'

describe 'the login process' do
  before :each do
    User.create(email: 'user@example.com', password: 'password', first_name: 'test', last_name: 'test')
  end

  it 'signs me in' do
    visit '/u/sign_in'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    expect(page).to have_content 'Your Dashboard'
  end
end
