include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :form do
    deal
    title FFaker::Company.catch_phrase
    document { fixture_file_upload(Rails.root.join('spec/fixtures/test_pdf.pdf'), 'application/pdf') }
  end
end
