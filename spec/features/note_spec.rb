require 'rails_helper'

def log_in
  visit '/u/sign_in'
  fill_in 'Email', with: 'user@example.com'
  fill_in 'Password', with: 'password'
  click_button 'Log in'
end

describe 'note authentication' do
  before do
    @user = create(:user)
    @investment = create(:investment)
    @note = create(:note)
    @investment.deal.notes.push(@note)
    @user.investments.push(@investment)
  end

  it 'shows the note if the user is properly authenticated' do
    log_in
    visit "/notes/#{@note.id}"
    expect(page).to have_content(@note.title)
  end
end
