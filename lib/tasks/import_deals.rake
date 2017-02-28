require 'roo'

desc 'Imports deal data from Excel files'

namespace :importer do
  task :deals => :environment do
    # grab all files in the deals folder
    files = Dir["/lib/deals/*"]

    files.each do |file|
      puts "Opening file #{file}..."
      xlsx = Roo::Spreadsheet.open(file)

      xlsx.each_row_streaming do |row|
        puts row.inspect
      end
    end
  end
end