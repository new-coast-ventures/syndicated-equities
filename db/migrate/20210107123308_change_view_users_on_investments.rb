class ChangeViewUsersOnInvestments < ActiveRecord::Migration[5.2]

  def self.up
    change_column :investments, :view_users, :text
  end

  def self.down
    change_column :investments, :view_users, :string
  end
end
