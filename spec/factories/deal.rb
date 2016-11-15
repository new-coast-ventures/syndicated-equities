FactoryGirl.define do
  factory :deal do
    title FFaker::Company.name
    description FFaker::Company.catch_phrase
    date FFaker::Time.date
  end
end
