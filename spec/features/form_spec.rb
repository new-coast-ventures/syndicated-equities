require 'rails_helper'

def log_in
  visit '/u/sign_in'
  fill_in 'Email', with: 'user@example.com'
  fill_in 'Password', with: 'password'
  click_button 'Log in'
end

describe 'form authentication' do
  before do
    @user = create(:user)
    @investment = create(:investment)
    @form = create(:form)
    @investment.deal.forms.push(@form)
    @user.investments.push(@investment)
  end

  it 'shows the form if the user is properly authenticated' do
    log_in
    visit "/forms/#{@form.id}"
    expect(page).to have_content(@form.title)
  end

  it 'does not show the form if the user is not properly authenticated' do
    log_in
    visit "/forms/#{@form.id + 1}"
    expect(page).to have_content('Not authorized')
  end
end
