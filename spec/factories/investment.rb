FactoryGirl.define do
  factory :investment do
    deal
    amount_invested 500_000
    invested_on FFaker::Time.date
  end
end
