class AddClassificationToCompany < ActiveRecord::Migration
  def change
  	add_column :companies, :classification, :string, default: "Uncategorised"
  end
end
