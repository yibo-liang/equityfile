class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :posted_by
      t.integer :posted_to
      t.string :content

      t.timestamps null: false
      t.belongs_to :user, index: true
    end
  end
end
