class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.string :location, default: "N/A"
      t.boolean :group_meeting, default: false
      t.integer :user_id

	  t.belongs_to :user, class_name: 'User', foreign_key: :user_id, index: true

      t.timestamps null: false
    end
  end
end
