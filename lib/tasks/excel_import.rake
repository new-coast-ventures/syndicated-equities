require 'roo'

desc 'Imports investment data from Excel file'
task :excel_import, filename do |t, file|
  xlsx = Roo::Spreadsheet.open(file)
  xlsx.each_row_streaming(offset: 2) do |row|
    
  end
end
