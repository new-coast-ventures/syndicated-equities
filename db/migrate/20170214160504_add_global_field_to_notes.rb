class AddGlobalFieldToNotes < ActiveRecord::Migration
  def change
    change_table :notes do |t|
      t.boolean :global, default: false
    end
    change_column_null :notes, :deal_id, true
  end
end
