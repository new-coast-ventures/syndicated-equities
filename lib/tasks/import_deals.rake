require "roo"
require "set"

namespace :importer do
  desc "Imports deal data from Excel files"
  task :deals => :environment do
    @deals = {}
    files = Dir["#{Rails.root}/lib/deals/*"]

    # Load Deals
    puts "Creating deals..."
    create_deals(files)

    # Load Invsetments
    puts "Creating investments..."
    create_investments(files)
  end

  def create_deals(files)
    deals = Set.new
    files.each do |file|
      xlsx = Roo::Spreadsheet.open(file)
      xlsx.each_row_streaming(offset: 1) do |row|
        title = sanitized_string_from(row[0])
        deals << title
        print "."
      end
    end

    values = deals.to_a.map { |title| "('#{title}', '#{Time.now}', '#{Time.now}')" }.join(",")
    ActiveRecord::Base.connection.execute("INSERT INTO deals (title, created_at, updated_at) VALUES #{values}")
    Deal.pluck(:id, :title).map { |d| @deals[d[1]] = d[0] } 
  end

  def create_investments(files)  
    investments = []
    files.each do |file|
      xlsx = Roo::Spreadsheet.open(file)
      xlsx.each_row_streaming(offset: 1) do |row|
        title  = sanitized_string_from(row[0])
        first  = sanitized_string_from(row[1])
        last   = sanitized_string_from(row[2])
        entity = sanitized_string_from(row[4])
        amount = sanitized_int_from(row[3])

        if deal_id = @deals[title]
          print "."
          investments << "(#{deal_id}, #{amount}, '#{first}', '#{last}', '#{entity}', '#{Time.now}', '#{Time.now}')"
        end
      end
    end

    ActiveRecord::Base.connection.execute("INSERT INTO investments (deal_id, amount_invested, investor_first_name, investor_last_name, investing_entity, created_at, updated_at) VALUES #{investments.join(',')}")
  end

  def sanitized_int_from(key)
    key&.value || 0
  end

  def sanitized_string_from(key)
    (key&.value || "").to_s.strip.gsub("'", %q(\\\'))
  end
end