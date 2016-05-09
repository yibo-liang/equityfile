class AddAssestsToCompany < ActiveRecord::Migration
  def change
  	add_column :companies, :assets, :decimal, :precision => 8, :scale => 2, default: 0.00
  	add_column :companies, :equity_assets, :decimal, :precision => 8, :scale => 2, default: 0.00
  	add_column :companies, :uk_equity_assets, :decimal, :precision => 8, :scale => 2, default: 0.00
  end
end
