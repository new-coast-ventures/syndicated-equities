class RemoveNullConstraintOnFormDeals < ActiveRecord::Migration
  def change
    change_column_null(:forms, :deal_id, true)
  end
end
