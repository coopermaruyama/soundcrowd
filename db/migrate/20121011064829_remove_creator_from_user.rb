class RemoveCreatorFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :creator
    add_column :users, :user_id, :integer
      end

  def down
  	remove_column :users, :user_id, :integer
    add_column :users, :creator, :integer
  end
end
