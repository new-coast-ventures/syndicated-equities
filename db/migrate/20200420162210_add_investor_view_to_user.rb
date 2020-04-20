class AddInvestorViewToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :investor_view, :boolean
  end
end
