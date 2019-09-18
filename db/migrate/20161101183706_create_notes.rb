# ================================================
# RUBY->MIGRATION->CREATENOTES ===================
# ================================================
class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      t.integer :deal_id, null: false
      t.string :title, null: false
      t.text :content, null: false
      t.timestamps null: false
    end
  end
end
