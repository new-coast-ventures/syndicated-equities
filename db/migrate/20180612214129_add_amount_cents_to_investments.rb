class AddAmountCentsToInvestments < ActiveRecord::Migration
  def change
    add_monetize :investments, :amount, amount: { null: true, default: nil }
  end
end
