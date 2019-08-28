class AddDescriptionToProperty < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :description, :text
  end
end
