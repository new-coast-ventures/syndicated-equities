class AddTotalInvestorGrossDistributionsAmountToProperty < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :total_investor_gross_distributions_amount, :string
  end
end
