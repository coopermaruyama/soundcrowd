class AddBpmToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :bpm, :integer

  end
end
