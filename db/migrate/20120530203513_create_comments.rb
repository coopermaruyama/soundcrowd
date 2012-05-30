class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :comment
      t.timestamp :timestamp
      t.integer :reply_of
      t.integer :track_timestamp

      t.timestamps
    end
  end
end
