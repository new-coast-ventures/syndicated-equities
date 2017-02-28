require 'roo'

desc 'Imports deal data from Excel files'

namespace :importer do
  task :deals => :environment do

    # grab all files in the deals folder
    files = Dir["#{Rails.root}/lib/deals/*"]

    files.each do |file|

      xlsx = Roo::Spreadsheet.open(file)

      xlsx.each(deal: 'Deal', date: 'Date', first_name: 'First Name', last_name: 'Last Name', entity: 'Entity', amount: 'Amount') do |hash|
        
        print "."
        date  = hash[:date] || Date.new(1900, 1, 1) # Grab date or set to Jan 1, 1900 so we know which dates we need to adjust
        first = hash[:first_name] || "Anonymous"
        last  = hash[:last_name] || "User"
        email = [first, last, "@temporary.com"].join("")
        deal  = hash[:deal] == "Deal"
        amount = hash[:amount] || 0

        deal = Deal.find_or_create_by(title: hash[:deal], description: "Description", date: date)

        unless user = User.find_by(first_name: first, last_name: last, email: email)
          user = User.create(first_name: first, last_name: last, email: email, password: "password")
        end

        deal.investments.find_or_create_by(user: user, amount_invested: amount, investing_entity: hash[:entity], invested_on: date)

      end
    end
  end
end