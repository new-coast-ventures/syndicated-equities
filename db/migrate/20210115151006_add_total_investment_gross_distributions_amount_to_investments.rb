class AddTotalInvestmentGrossDistributionsAmountToInvestments < ActiveRecord::Migration[5.2]
  def change
    add_column :investments, :total_investment_gross_distributions_amount, :string
  end
end
