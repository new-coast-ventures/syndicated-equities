class ImportDistributionsJob < ApplicationJob
  queue_as :default

  def perform(property_id, file, mapping)
    prop = Property.find(property_id)
    puts "--------- Starting Distributions import for #{prop.name} ---------"

    import_file = file.split("/")[-1]

    local_file = "lib/imports/#{import_file}"
    puts "--------- Importing #{local_file} ---------"

    xlsx = Roo::Spreadsheet.open(local_file)

    sheet = xlsx.sheet(0)

    # create clean hash for import
    gd_hash = sheet.parse(
      email: mapping["investor_email"], 
      investor_entity: mapping["investor_entity"], 
      amount: mapping["amount"], 
      date: mapping["distribution_date"], 
      clean:true
    )
    
    investments = prop.investments
  
    invalid_entities = []
    invalid_emails = []
    
    gd_hash.each do |row|
      # check if email is associated with an investment, if not add it to the invalid array. Not sure why we need this but it was a requirement
      if investments.where(investor_email: row[:email]).blank?
        invalid_emails << row[:email] unless (invalid_emails.include?(row[:email]) || row[:email].nil?)
      end

      # find investment associated with email AND entity to ensure we ass. the distribution to the correct investment
      investment = investments.where(investor_email: row[:email], investor_entity: row[:investor_entity])
      
      if !investment.blank?
        distribution = GrossDistribution.create(
          investment_id: investment.first.id,
          amount: row[:amount],
          distribution_date: row[:date],
          description: row[:investor_entity]
        )
        puts distribution.inspect
      else
        # check if investor entity is associated with an investment, if not add it to the invalid array
        invalid_entities << row[:investor_entity] unless (invalid_entities.include?(row[:investor_entity]) || row[:investor_entity].nil?)
      end
    end
    
    # remove the local file
    File.delete(local_file) if File.exist?(local_file)
    
    # send the invalid entries via email
    errors = {invalid_entities: invalid_entities, invalid_emails: invalid_emails}

    AdminMailer.distribution_import_complete(errors, prop.name).deliver_now
    puts "--------- Finished Distributions import for #{prop.name} ---------"
  rescue => e  
    puts "--------- ERROR with Distributions import for #{prop.name} ---------"
    puts "--------- ERROR: #{e} ---------"
    # remove the local file
    File.delete(local_file) if File.exist?(local_file)
    AdminMailer.distribution_import_error(errors, prop.name).deliver_now
  end
end
