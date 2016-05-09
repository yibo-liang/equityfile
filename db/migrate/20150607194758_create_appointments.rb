class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.belongs_to :user, index: true
      t.belongs_to :company, index: true
      t.boolean :accepted, default: false
      t.timestamps null: false
    end
  end
end
