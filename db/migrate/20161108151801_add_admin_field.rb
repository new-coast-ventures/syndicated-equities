class AddAdminField < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.boolean :admin
    end
  end
end
