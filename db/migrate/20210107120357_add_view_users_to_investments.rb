class AddViewUsersToInvestments < ActiveRecord::Migration[5.2]
  def change
    add_column :investments, :view_users, :text, array: true, default: []
  end
end
