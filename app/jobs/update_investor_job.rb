class UpdateInvestorJob < ApplicationJob
  queue_as :default

  def perform
    User.all.each do |investor|
      investor.update(
        total_investments_count: investor.total_investments,
        total_invested_amount: investor.total_invested
      )
    end
  rescue => e  
    puts "------- Error updating Investor Totals -----------"
    puts e
  end
end