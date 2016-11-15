class RemoveNullConstraintsFromInvestments < ActiveRecord::Migration
  def change
    change_column_null :investments, :user_id, true
  end
end
