class CreateMeetingTimes < ActiveRecord::Migration
  def change
    create_table :meeting_times do |t|
      t.datetime :time
      t.integer :meeting_id
      t.integer :meeting_instance_id, default: nil
      t.boolean :reserved, default: false

      t.belongs_to :meeting, class_name: 'Meeting', foreign_key: :meeting_id, index: true
      t.belongs_to :meeting_instance, class_name: 'MeetingInstance', foreign_key: :meeting_instance_id, index: true

      t.timestamps null: false
    end
  end
end
