class RemoveNullConstraintOnFormDeals < ActiveRecord::Migration[5.1]
  def change
    change_column_null(:forms, :deal_id, true)
  end
end
