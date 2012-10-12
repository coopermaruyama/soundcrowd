class AddIndexToProductionsUsers < ActiveRecord::Migration
  def change
  	add_index :productions_users, [:production_id, :user_id], :unique => true
  end
end
