class AddAncestryToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :ancestry, :string
    add_index :versions, :ancestry
  end
end
