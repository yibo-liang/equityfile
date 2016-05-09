class AddCreatedByUserToAppointment < ActiveRecord::Migration
  def change
  	add_column :appointments, :created_by_user, :boolean
  end
end
