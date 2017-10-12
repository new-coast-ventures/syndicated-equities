class AddPropertyToDeals < ActiveRecord::Migration
  def change
    add_reference :deals, :property, index: true, foreign_key: true
  end
end
