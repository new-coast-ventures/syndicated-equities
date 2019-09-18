class AddPropertyToDeals < ActiveRecord::Migration[5.1]
  def change
    add_reference :deals, :property, index: true, foreign_key: true
  end
end
