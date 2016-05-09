class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :country
      t.string :address_line_1
      t.string :address_line_2
      t.string :address_line_3
      t.string :postcode
      t.string :symbol

      t.timestamps null: false
    end
  end
end
