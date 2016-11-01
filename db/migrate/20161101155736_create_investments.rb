# ================================================
# RUBY->MIGRATION->CREATEINVESTMENTS =============
# ================================================
class CreateInvestments < ActiveRecord::Migration
  def change
    create_table :investments do |t|
      t.integer :user_id, null: false
      t.integer :deal_id, null: false
      t.integer :amount_invested, null: false
      t.date :invested_on, null: false
      t.timestamps null: false
    end
  end
end
