class AddFormLibraryToForms < ActiveRecord::Migration[5.2]
  def change
    add_column :forms, :form_library, :boolean
  end
end
