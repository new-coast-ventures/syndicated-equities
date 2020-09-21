class ImportDistributionsJob < ApplicationJob
  queue_as :default

  def perform(property_id, gd_hash)
    prop = Property.find(property_id)
    puts "--------- Starting Distributions import for #{prop.name} ---------"
    gd_hash = JSON.parse(gd_hash)
    investments = prop.investments
  
    invalid_entities = []
    invalid_emails = []
    
    gd_hash.each do |row|
      email = row['email']&.downcase
      investor_entity = row['investor_entity']
      # check if email is associated with an investment, if not add it to the invalid array. Not sure why we need this but it was a requirement
      if investments.where(investor_email: email).blank?
        invalid_emails << email unless (invalid_emails.include?(email) || email.nil?)
      end

      # find investment associated with email AND entity to ensure we associate the distribution to the correct investment
      investment = investments.where(investor_email: email, investor_entity: investor_entity)
      
      if !investment.blank?
        distribution = GrossDistribution.create(
          investment_id: investment.first.id,
          amount: row["amount"],
          distribution_date: row["date"],
          description: investor_entity
        )
        puts distribution.inspect
      else
        # check if investor entity is associated with an investment, if not add it to the invalid array
        invalid_entities << row["investor_entity"] unless (invalid_entities.include?(row["investor_entity"]) || row["investor_entity"].nil?)
      end
    end
    
    # send the invalid entries via email
    errors = {invalid_entities: invalid_entities, invalid_emails: invalid_emails}

    AdminMailer.distribution_import_complete(errors, prop.name).deliver_now
    puts "--------- Finished Distributions import for #{prop.name} ---------"
  rescue => e  
    puts "--------- ERROR with Distributions import for #{prop.name} ---------"
    puts "--------- ERROR: #{e} ---------"
    # remove the local file
    AdminMailer.distribution_import_error(e, prop.name).deliver_now
  end
end
