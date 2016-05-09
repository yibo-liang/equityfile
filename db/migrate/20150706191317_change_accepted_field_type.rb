class ChangeAcceptedFieldType < ActiveRecord::Migration
  def change
		add_column :users, :accepted, :integer, null: false, default: 0, limit: 1
  end
end
