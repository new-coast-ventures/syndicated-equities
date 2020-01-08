class AddGrossDistributionPercentageToInvestments < ActiveRecord::Migration[5.2]
  def change
    add_column :investments, :gross_distribution_percentage, :integer
  end
end
