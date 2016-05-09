class CreateMeetingInstances < ActiveRecord::Migration
  def change
    create_table :meeting_instances do |t|
      t.integer :meeting_id
      t.integer :investor_id
      t.boolean :accepted
      t.integer :time_id

      t.belongs_to :meeting, class_name: 'Meeting', foreign_key: :meeting_id, index: true
      t.belongs_to :user, class_name: 'User', foreign_key: :investor_id, index: true
      
      
      t.timestamps null: false
    end
  end
end
