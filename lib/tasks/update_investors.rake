namespace :investors do
  task :update_totals => :environment do
    puts "Updating Investors with totals..."
    if !Rails.env.development?
      UpdateInvestorJob.perform_now
    else
      User.all.each do |investor|
        investor.update(
          total_investments_count: investor.total_investments,
          total_invested_amount: investor.total_invested
        )
      end
    end
  end
end