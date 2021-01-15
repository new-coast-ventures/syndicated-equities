namespace :investments do
  task :update_totals => :environment do
    puts "Updating Investments with totals..."
    if !Rails.env.development?
      UpdateInvestmentsJob.perform_now
    else
      Investment.all.each do |investment|
        investment.update(
          total_investment_gross_distributions_amount: investment.total_gross_distribution,
        )
      end
    end
  end
end