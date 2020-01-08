class ChangeGrossDistributionsPercentageOnProperty < ActiveRecord::Migration[5.2]
  def change
    change_column :investments, :gross_distribution_percentage, :string
  end
end
