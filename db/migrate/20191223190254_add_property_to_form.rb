class AddPropertyToForm < ActiveRecord::Migration[5.2]
  def change
    add_reference :forms, :property, foreign_key: true
  end
end
