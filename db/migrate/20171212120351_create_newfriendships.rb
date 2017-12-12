class CreateNewfriendships < ActiveRecord::Migration
  def change
    create_table :newfriendships do |t|
      t.integer :user_id, index: true
      t.integer :new_friend_id, index: true
      
      t.timestamps null: false
    end
  end
end
