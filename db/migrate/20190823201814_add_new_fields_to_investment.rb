class AddNewFieldsToInvestment < ActiveRecord::Migration[5.1][5.2]
  def change
    add_column :investments, :investor_entity, :string
    add_column :investments, :gross_distribution, :string
  end
end
