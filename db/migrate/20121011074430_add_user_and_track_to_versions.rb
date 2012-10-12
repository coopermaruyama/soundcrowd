class AddUserAndTrackToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :user_id, :integer

    add_column :versions, :project_id, :integer

  end
end
