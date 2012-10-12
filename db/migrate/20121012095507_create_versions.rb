class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.integer :forked_from
      t.string :source_file
      t.string :audio_file
      t.integer :track_id
      t.integer :user_id

      t.timestamps
    end
    add_index :versions, :track_id
    add_index :versions, :forked_from
    add_index :versions, :user_id
    add_index :versions, [:user_id, :track_id]
  end
end
