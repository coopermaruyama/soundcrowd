class RemoveBpmFromTracks < ActiveRecord::Migration
  def up
    remove_column :tracks, :bpm
      end

  def down
    add_column :tracks, :bpm, :integer
  end
end
