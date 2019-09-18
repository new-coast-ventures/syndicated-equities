class RemoveNullConstraintsFromInvestments < ActiveRecord::Migration[5.1]
  def change
    change_column_null :investments, :user_id, true
  end
end
