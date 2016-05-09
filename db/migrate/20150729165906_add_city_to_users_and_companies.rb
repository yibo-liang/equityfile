class AddCityToUsersAndCompanies < ActiveRecord::Migration
  def change
  	add_column :users, :city, :string 
  	add_column :users, :country, :string 
  	add_column :companies, :city, :string 
  end
end
