class AddContactToUsers < ActiveRecord::Migration
  def change
    add_column :users, :contact, :boolean
  end
end
