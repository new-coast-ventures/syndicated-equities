class AddGlobalFieldToNotes < ActiveRecord::Migration
  def change
    change_table :notes do |t|
      t.string :investor_email
    end
    change_column_null :notes, :deal_id, true
  end
end
