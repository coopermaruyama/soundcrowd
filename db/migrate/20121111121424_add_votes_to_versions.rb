class AddVotesToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :votes, :integer, :default => 0

  end
end
