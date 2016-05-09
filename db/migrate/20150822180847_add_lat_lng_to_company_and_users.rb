class AddLatLngToCompanyAndUsers < ActiveRecord::Migration
  def change
  	add_column :companies, :lat, :decimal, :precision => 15, :scale => 10, :default => 0.0
  	add_column :companies, :lng, :decimal, :precision => 15, :scale => 10, :default => 0.0
  	add_column :users, :lat, :decimal, :precision => 15, :scale => 10, :default => 0.0
  	add_column :users, :lng, :decimal, :precision => 15, :scale => 10, :default => 0.0
  end
end
