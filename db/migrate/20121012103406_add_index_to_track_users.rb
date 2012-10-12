class AddIndexToTrackUsers < ActiveRecord::Migration
  def change
  	
  add_index :track_users, :user_id
  add_index :track_users, :track_id
  add_index :track_users, [:track_id, :user_id], unique: true
  end
end
