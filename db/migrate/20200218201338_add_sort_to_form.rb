class AddSortToForm < ActiveRecord::Migration[5.2]
  def change
    add_column :forms, :sort, :integer
  end
end
