class CreateTagRelations < ActiveRecord::Migration
  def change
    create_table :tag_relations do |t|
      t.integer :tag_id
      t.integer :tagged_track

      t.timestamps
    end
  end
end
