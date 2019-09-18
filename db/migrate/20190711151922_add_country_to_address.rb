class AddCountryToAddress < ActiveRecord::Migration[5.1][5.2]
  def change
    add_column :addresses, :country, :text
  end
end
