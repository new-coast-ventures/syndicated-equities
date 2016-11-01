# ================================================
# RUBY->MIGRATION->CREATEFORMS ===================
# ================================================
class CreateForms < ActiveRecord::Migration
  def change
    create_table :forms do |t|
      t.integer :deal_id, null: false
      t.string :title, null: false
      t.text :description
      t.attachment :document
      t.timestamps null: false
    end
  end
end
