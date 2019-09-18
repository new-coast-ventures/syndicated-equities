class AddViewerRoleToUsers < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.boolean :viewer
    end
  end
end
