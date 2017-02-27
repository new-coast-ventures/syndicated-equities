class AddGenericFieldToForms < ActiveRecord::Migration
  def change
    change_table :forms do |t|
      t.boolean :generic, default: false
    end
  end
end
