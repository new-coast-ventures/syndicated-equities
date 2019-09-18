class AddGenericFieldToForms < ActiveRecord::Migration[5.1]
  def change
    change_table :forms do |t|
      t.boolean :generic, default: false
    end
  end
end
