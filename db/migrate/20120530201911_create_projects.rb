class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.integer :creator_id
      t.integer :BPM
      t.integer :versions
      t.integer :followers
      t.string :tags

      t.timestamps
    end
  end
end
