class AddNicknameToProperty < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :nickname, :string
  end
end
