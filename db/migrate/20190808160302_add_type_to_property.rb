class AddTypeToProperty < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :type, :string
  end
end
