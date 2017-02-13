class AddViewerRoleToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.boolean :viewer
    end
  end
end
