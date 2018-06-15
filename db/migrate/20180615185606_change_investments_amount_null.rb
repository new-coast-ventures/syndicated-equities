class ChangeInvestmentsAmountNull < ActiveRecord::Migration
  def change
    change_column_null(:investments, :amount_invested, true)
  end
end
