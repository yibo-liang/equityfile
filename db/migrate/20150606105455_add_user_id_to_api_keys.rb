class AddUserIdToApiKeys < ActiveRecord::Migration
  def change
  	change_table :api_keys do |t|
			t.belongs_to :user, index: true	
		end
  end
end
