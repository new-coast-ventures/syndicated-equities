FactoryGirl.define do
  factory :note do
    deal
    title FFaker::Company.catch_phrase
    content FFaker::HTMLIpsum.body
  end
end
