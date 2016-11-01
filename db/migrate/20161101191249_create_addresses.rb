# ================================================
# RUBY->MIGRATION->CREATEADDRESSES ===============
# ================================================
# TODO: validations
class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :user_id, null: false
      t.string :line1, null: false
      t.string :line2
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip, null: false
      t.timestamps null: false
    end
  end
end
