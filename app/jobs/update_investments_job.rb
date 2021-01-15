class UpdateInvestmentsJob < ApplicationJob
  queue_as :default

  def perform
    Investment.all.each do |investment|
      investment.update(
        total_investment_gross_distributions_amount: investment.total_gross_distribution,
      )
    end
  rescue => e  
    puts "------- Error updating Investment Totals -----------"
    puts e 
  end
end