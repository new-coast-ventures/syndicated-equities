# ================================================
# RUBY->MIGRATION->ADDUSERFIELDS =================
# ================================================
class AddUserFields < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
    end
  end
end
