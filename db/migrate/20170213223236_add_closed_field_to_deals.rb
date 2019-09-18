class AddClosedFieldToDeals < ActiveRecord::Migration[5.1]
  def change
    add_column :deals, :closed_at, :datetime
  end
end
