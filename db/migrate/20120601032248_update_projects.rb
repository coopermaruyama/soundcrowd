class UpdateProjects < ActiveRecord::Migration
  def up
    remove_column :tracks, :BPM
  end
  

  def down
  end
end
