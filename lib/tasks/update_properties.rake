namespace :properties do
  task :update_totals => :environment do
    puts "Updating Properties with totals..."
    if !Rails.env.development?
      UpdatePropertyJob.perform_now
    else
      Property.all.each do |prop|
        prop.update(
          total_investor_gross_distributions_amount: prop.total_investor_gross_distributions,
        )
      end
    end
  end
end