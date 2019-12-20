class RemoveNotesFromProperties < ActiveRecord::Migration[5.2]
  def change
    remove_reference :properties, :note, foreign_key: true
  end
end
