class AddApprovedField < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.boolean :approved
    end
  end
end
