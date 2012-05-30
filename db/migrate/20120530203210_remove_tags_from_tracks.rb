class RemoveTagsFromTracks < ActiveRecord::Migration
  def up
    remove_column :tracks, :tags
      end

  def down
    add_column :tracks, :tags, :string
  end
end
