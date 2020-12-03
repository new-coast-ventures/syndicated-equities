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

  task :update_investment_with_decimal => :environment do
    puts "Updating Investments with decimals..."
    if !Rails.env.development?
      UpdateInvestorJob.perform_now
    else
      Investment.all.each do |inv|
        next if inv.amount_invested.include?(".")
        inv.update(
          amount_invested: "#{inv.amount_invested}.00"
        )
      end
    end
  end
end