class RemoveBpmFromProjects < ActiveRecord::Migration
  def up
    remove_column :projects, :BPM
      end

  def down
    add_column :projects, :BPM, :integer
  end
end
