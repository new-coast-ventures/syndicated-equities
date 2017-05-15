require 'roo'

desc 'Imports deal data from Excel files'

namespace :importer do
  task :deals => :environment do

    # grab all files in the deals folder
    files = Dir["#{Rails.root}/lib/deals/*"]

    files.each do |file|

      xlsx = Roo::Spreadsheet.open(file)

      xlsx.each_row_streaming(offset: 1) do |row|

        title  = row[0] ? (row[0].value || "").to_s.strip : ""
        first  = row[2] ? (row[2].value || "Anonymous").to_s.strip : ""
        last   = row[3] ? (row[3].value || "").to_s.strip : ""
        email  = [first.tr('.', ''), last.tr('.', '')].join("_").downcase.tr(' ', '_').strip + "@temporary.com"
        entity = row[4] ? (row[4].value || "").to_s.strip : ""
        amount = row[5] ? (row[5].value || 0) : 0
        date   = row[1].value.nil? ? Date.new(1900, 1, 1) : row[1].value
        ddate  = Date.new(1900, 1, 1)

        deal = Deal.find_or_create_by(title: title, description: "-", date: ddate)
        user = User.insert_with(first_name: first, last_name: last, email: email, password: "password", approved: true)

        if deal && user
          begin
            deal.investments.find_or_create_by(investor: user, amount_invested: amount, investing_entity: entity, invested_on: date)
            print "."
          rescue
            puts "Error: #{row.inspect}"
          end
        end
      end
    end
  end
end