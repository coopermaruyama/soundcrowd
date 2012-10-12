class RemoveCreatorFromVersions < ActiveRecord::Migration
  def up
    remove_column :versions, :creator
      end

  def down
    add_column :versions, :creator, :integer
  end
end
