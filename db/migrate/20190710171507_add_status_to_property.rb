class AddStatusToProperty < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :status, :string
  end
end
