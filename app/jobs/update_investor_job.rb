class UpdateInvestorJob < ApplicationJob
  queue_as :investor

  def perform(user_ids = nil)
    users = user_ids ? User.where(id: user_ids) : User.all

    users.each do |investor|
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