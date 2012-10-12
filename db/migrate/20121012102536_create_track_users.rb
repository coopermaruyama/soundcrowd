class CreateTrackUsers < ActiveRecord::Migration
  def change
    create_table :track_users do |t|
      t.integer :user_id
      t.integer :track_id

      t.timestamps
    end
  end

end
