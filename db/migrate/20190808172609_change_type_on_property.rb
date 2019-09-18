class ChangeTypeOnProperty < ActiveRecord::Migration[5.1][5.2]
  def change
    rename_column :properties, :type, :property_type
  end
end
