# ================================================
# RUBY->MIGRATION->CREATEDEALS ===================
# ================================================
class CreateDeals < ActiveRecord::Migration[5.1]
  def change
    create_table :deals do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.date :date, null: false
      t.timestamps null: false
    end
  end
end
