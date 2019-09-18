class AddAdminField < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.boolean :admin
    end
  end
end
