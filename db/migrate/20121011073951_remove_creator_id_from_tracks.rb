class RemoveCreatorIdFromTracks < ActiveRecord::Migration
  def up
    remove_column :tracks, :creator_id
      end

  def down
    add_column :tracks, :creator_id, :string
  end
end
