FactoryGirl.define do
  factory :address do
    user
    line1 FFaker::AddressUS.street_address
    city  FFaker::AddressUS.city
    state FFaker::AddressUS.state_abbr
    zip   FFaker::AddressUS.zip_code
  end
end
