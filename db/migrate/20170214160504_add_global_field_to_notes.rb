class AddGlobalFieldToNotes < ActiveRecord::Migration[5.1]
  def change
    change_table :notes do |t|
      t.boolean :global, default: false
    end
    change_column_null :notes, :deal_id, true
  end
end
