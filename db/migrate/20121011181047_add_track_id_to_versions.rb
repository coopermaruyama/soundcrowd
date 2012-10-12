class AddTrackIdToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :track_id, :integer

  end
end
