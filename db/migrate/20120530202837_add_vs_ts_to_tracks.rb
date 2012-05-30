class AddVsTsToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :VSTs, :integer

  end
end
