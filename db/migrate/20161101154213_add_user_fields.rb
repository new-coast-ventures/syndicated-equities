# ================================================
# RUBY->MIGRATION->ADDUSERFIELDS =================
# ================================================
class AddUserFields < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
    end
  end
end
