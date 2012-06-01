class RemoveFollowerIdFromFollows < ActiveRecord::Migration
  def up
    remove_column :follows, :follwer_id
  end

  def down
  end
end
