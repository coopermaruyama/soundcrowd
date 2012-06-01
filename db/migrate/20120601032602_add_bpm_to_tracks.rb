class AddBpmToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :bpm, :integer

  end
end
