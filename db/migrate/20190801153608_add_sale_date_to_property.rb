class AddSaleDateToProperty < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :sale_date, :datetime
  end
end
