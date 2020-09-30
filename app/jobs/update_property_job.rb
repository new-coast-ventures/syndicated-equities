class UpdatePropertyJob < ApplicationJob
  queue_as :default

  def perform
    Property.all.each do |prop|
      prop.update(
        total_investor_gross_distributions_amount: prop.total_investor_gross_distributions,
      )
    end
  rescue => e  
    puts "------- Error updating Property Totals -----------"
    puts e 
  end
end