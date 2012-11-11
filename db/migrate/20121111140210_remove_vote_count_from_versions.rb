class RemoveVoteCountFromVersions < ActiveRecord::Migration
  def up
    remove_column :versions, :votes
      end

  def down
    add_column :versions, :votes, :integer
  end
end
