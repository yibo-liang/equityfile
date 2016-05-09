class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :password_hash
      t.string :password_salt
      t.string :address
      t.string :firstname
      t.string :surname

      t.timestamps null: false
    end
  end
end
