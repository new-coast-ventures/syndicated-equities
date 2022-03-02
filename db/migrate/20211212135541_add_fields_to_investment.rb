class AddFieldsToInvestment < ActiveRecord::Migration[5.2]
  def change
    add_column :investments, :investor_alt_email, :string
    add_column :investments, :closed, :boolean
  end
end
