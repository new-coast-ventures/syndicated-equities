# Assumes the following file structure:
# Cell A1 = deal name
# Cell B1 = deal date
# Row 2 = header row
# Data rows:
# Column A = first name
# Column B = last name
# Column C = investing entity
# Column D = investor email
# Column E = amount invested

require 'roo'
require 'ffaker'
desc 'Imports investment data from Excel file'
task :excel_import, [:file] => [:environment] do |t, args|
  # open the file
  file = args[:file]
  puts "Opening #{file}"
  xlsx = Roo::Spreadsheet.open(file)
  puts xlsx.cell(1,1)
  # extract and save the deal
  deal = Deal.new(title: xlsx.cell(1,1), description: 'Description TBD', date: xlsx.cell(1,2))
  deal.save!
  # generate sample form data - remove for production
  form = Form.new(deal: deal, title: 'Form K-1', description: FFaker::Company.catch_phrase)
  form.save!(validate: false)
  # generate sample note data - remove for production
  2.times { Note.create(deal: deal, title: FFaker::Company.catch_phrase, content: FFaker::HTMLIpsum.body) }
  # add the user/investment data to the DB
  xlsx.each_row_streaming(offset: 2) do |row|
    next if row[0].empty?
    puts "Adding #{row[0]} #{row[1]}"
    email = row[2].strip
    puts email
    user = create_user # remove for production
    create_investment
  end
end

def create_user
  user = User.new(first_name: row[0], last_name: row[1], email: email, password: 'syndicated', approved: true, admin: true)
  user.save!
  user
end

def create_investment
  investment = Investment.new
  investment.investor = user # remove for production
  investment.deal = deal
  investment.investing_entity = row[2].value
  investment.amount_invested = row[3].value
  investment.invested_on = deal.date
  investment.investor_email = email
  investment.save!
end
