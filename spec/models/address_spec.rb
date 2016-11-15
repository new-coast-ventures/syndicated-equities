require 'rails_helper'

RSpec.describe Address, type: :model do
  before do
    @address = create(:address)
  end

  it { should belong_to :user }

  it 'has a name method that prints out a formatted version of the address' do
    expect(@address.name).to eq(@address.line1 + ' ' + @address.city + ', ' + @address.state + ' ' + @address.zip)
  end
end
