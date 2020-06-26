class AddOpenFieldsToProperty < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :funding_amount, :string
    add_column :properties, :target_irr, :string
    add_column :properties, :average_annual_return, :string
  end
end
