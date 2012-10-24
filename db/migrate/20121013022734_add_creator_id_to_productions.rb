class AddCreatorIdToProductions < ActiveRecord::Migration
  def change
    add_column :productions, :creator_id, :integer

  end
end
