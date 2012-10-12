class RemoveProjectIdFromVersions < ActiveRecord::Migration
  def up
    remove_column :versions, :project_id
      end

  def down
    add_column :versions, :project_id, :integer
  end
end
