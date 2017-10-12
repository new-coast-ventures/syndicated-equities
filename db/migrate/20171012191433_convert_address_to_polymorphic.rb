class ConvertAddressToPolymorphic < ActiveRecord::Migration
  def change
    # Address: change user -> addressable
    rename_column :addresses, :user_id, :addressable_id
    add_column :addresses, :addressable_type, :string

    # Form: change deal -> owner
    rename_column :forms, :deal_id, :owner_id
    add_column :forms, :owner_type, :string
  end
end
