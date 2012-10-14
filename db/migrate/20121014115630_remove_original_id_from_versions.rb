class RemoveOriginalIdFromVersions < ActiveRecord::Migration
  def up
    remove_column :versions, :original_id
      end

  def down
    add_column :versions, :original_id, :integer
  end
end
