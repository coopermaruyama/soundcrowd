class RenameForkedFromToVersions < ActiveRecord::Migration
  def change
  	remove_column :versions, :forked_from, :integer
  	add_column :versions, :original_id, :integer
  end
end
