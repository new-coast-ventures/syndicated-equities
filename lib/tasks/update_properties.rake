namespace :properties do
  task :update_totals, [:property_ids] => :environment do |task, args|
    property_ids = args[:property_ids]
    puts property_ids
    puts "Updating Properties with totals..."


    if !Rails.env.development?
      UpdatePropertyJob.perform_now(property_ids)
    else
      properties = property_ids ? Property.where(id: property_ids) : Property.all
      puts properties.count
      properties.each do |prop|
        prop.update(
          total_investor_gross_distributions_amount: prop.total_investor_gross_distributions,
        )
      end
    end
  end
end