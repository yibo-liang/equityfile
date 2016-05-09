class AddIndexToUserForCompany < ActiveRecord::Migration
  def change
  	change_table :users do |t|
  		t.belongs_to :company, index:true
  	end
  end
end
