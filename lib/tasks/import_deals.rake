require 'roo'

desc 'Imports deal data from Excel files'

namespace :importer do
  task :deals => :environment do

    # grab all files in the deals folder
    files = Dir["#{Rails.root}/lib/deals/*"]

    files.each do |file|

      xlsx = Roo::Spreadsheet.open(file)

      xlsx.each(deal: 'Deal', date: 'Date', first_name: 'First Name', last_name: 'Last Name', entity: 'Entity', amount: 'Amount') do |hash|
        
        deal = Deal.find_or_create_by(title: hash[:deal])
        user = User.find_or_create_by(first_name: hash[:first_name], last_name: hash[:last_name])
        deal.investments.find_or_create_by(user: user, amount_invested: hash[:amount], investing_entity: hash[:entity])

      end
    end
  end
end