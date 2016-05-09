class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
    	t.string :title
    	t.string :startsAt
    	t.string :endsAt
    	t.boolean :editable, default: false
    	t.boolean :deletable, default: false
    	t.boolean :incrementsBadgeTotal, default: true
      t.belongs_to :appointment, index: true
      t.string :event_type
      t.timestamps null: false
    end
  end
end
