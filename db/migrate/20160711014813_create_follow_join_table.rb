class CreateFollowJoinTable < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.integer :following_id, index: true, :null => false
      t.integer :follower_id, index: true, :null => false
      
      t.timestamps null: false
     end
    add_index :follows, [:following_id, :follower_id], unique: true
  end
end
