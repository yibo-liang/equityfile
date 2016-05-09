class CreateTagRelations < ActiveRecord::Migration
  def change
    create_table :tag_relations do |t|
      t.belongs_to :user, index: true
      t.belongs_to :tag, index: true
      t.timestamps null: false
    end
  end
end
