class AddCurrencyToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :currency, :string
  end
end
