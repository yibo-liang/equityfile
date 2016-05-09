class AddAddressLinesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :address_line_1, :string
    add_column :users, :address_line_2, :string
    add_column :users, :address_line_3, :string
    add_column :users, :postcode, :string
  end
end
