class AddTotalFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :total_investments_count, :string
    add_column :users, :total_invested_amount, :string
  end
end
