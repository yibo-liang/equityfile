class AddApplicationStatusToCompanies < ActiveRecord::Migration
  def change
  	change_table :companies do |t|
			t.integer :application_status, null: false, default: 0, limit: 1				
		end
	end
end
