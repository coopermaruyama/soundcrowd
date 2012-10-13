class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.integer :forked_from
      t.string :source_file
      t.string :audio_file
      t.integer :production_id
      t.integer :user_id, :null => false

      t.timestamps
    end
    add_index :versions, :production_id
    add_index :versions, :forked_from
    add_index :versions, :user_id
    add_index :versions, [:user_id, :production_id]
  end
end
