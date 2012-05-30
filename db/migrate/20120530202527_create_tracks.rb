class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.integer :creator
      t.integer :votes
      t.integer :forks
      t.boolean :original
      t.integer :forked_from
      t.datetime :created_at

      t.timestamps
    end
  end
end
