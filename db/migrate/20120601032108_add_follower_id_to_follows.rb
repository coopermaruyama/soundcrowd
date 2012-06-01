class AddFollowerIdToFollows < ActiveRecord::Migration
  def change
    add_column :follows, :follower_id, :integer

  end
end
