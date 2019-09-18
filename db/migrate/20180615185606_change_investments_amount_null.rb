class ChangeInvestmentsAmountNull < ActiveRecord::Migration[5.1]
  def change
    change_column_null(:investments, :amount_invested, true)
  end
end
