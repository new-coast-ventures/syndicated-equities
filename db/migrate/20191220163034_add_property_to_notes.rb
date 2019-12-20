class AddPropertyToNotes < ActiveRecord::Migration[5.2]
  def change
    add_reference :notes, :property, foreign_key: true
  end
end
