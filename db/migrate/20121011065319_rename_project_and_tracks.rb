class RenameProjectAndTracks < ActiveRecord::Migration
  def change
  	rename_table :projects, :songs
  	rename_table :tracks, :versions
  end
end
