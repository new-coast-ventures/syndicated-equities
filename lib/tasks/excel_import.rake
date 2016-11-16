require 'roo'

desc 'Imports investment data from Excel file'
task :excel_import, [:file] => [:environment] do |t, args|
  file = args[:file]
  puts "Opening #{file}"
  xlsx = Roo::Spreadsheet.open(file)
  puts xlsx.cell(1,1)
  deal = Deal.new(title: xlsx.cell(1,1), description: 'Description TBD', date: xlsx.cell(1,2))
  deal.save
  xlsx.each_row_streaming(offset: 2) do |row|
    puts "Adding #{row[1]}"
    email = "#{row[0].value.downcase.strip}.#{row[1].value.downcase.strip}@example.com"
    puts email
    user = User.new(first_name: row[0], last_name: row[1], email: email, password: 'syndicated', approved: true, admin: true)
    user.save!
    investment = Investment.new
    investment.investor = user
    investment.deal = deal
    investment.investing_entity = row[2].value
    investment.amount_invested = row[3].value
    investment.invested_on = deal.date
    investment.save!
  end
end
