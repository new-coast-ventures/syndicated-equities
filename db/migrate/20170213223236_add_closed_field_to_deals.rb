class AddClosedFieldToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :closed_at, :datetime
  end
end
