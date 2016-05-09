class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.belongs_to :user, class_name: 'User', foreign_key: :user_id, index: true
      t.belongs_to :friend, class_name: 'User', foreign_key: :friend_id, index: true
      t.string :status

      t.timestamps null: false
    end
  end
  def down
  	drop :friendships
  end
end
