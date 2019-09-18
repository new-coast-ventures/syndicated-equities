class AddFieldsToInvestments < ActiveRecord::Migration[5.1]
  def change
    # remove null constraints
    change_column_null :investments, :invested_on, true
    change_column_null :deals, :description, true
    change_column_null :deals, :date, true

    # add investor name attrs on investments
    add_column :investments, :investor_first_name, :string
    add_column :investments, :investor_last_name, :string
  end
end
