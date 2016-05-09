class AddInvestorToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :investor, :boolean, default: false
  end
end
