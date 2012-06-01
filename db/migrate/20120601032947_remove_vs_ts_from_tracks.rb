class RemoveVsTsFromTracks < ActiveRecord::Migration
  def up
    remove_column :tracks, :VSTs
      end

  def down
    add_column :tracks, :VSTs, :integer
  end
end
