class AddFieldsToProperty < ActiveRecord::Migration[5.1][5.2]
  def change
    add_column :properties, :gross_distributions, :string
    add_column :properties, :internal_rate_of_return, :string
    add_column :properties, :equity_multiple, :string
  end
end
