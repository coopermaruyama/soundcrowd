class AddVstsToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :vsts, :string

  end
end
