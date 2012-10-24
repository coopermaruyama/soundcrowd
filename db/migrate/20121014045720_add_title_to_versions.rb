class AddTitleToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :title, :string

  end
end
