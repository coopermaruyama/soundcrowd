class RemoveFieldsDeviseFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :email
        remove_column :users, :password
        remove_column :users, :username
      end

  def down
    add_column :users, :username, :string
    add_column :users, :password, :string
    add_column :users, :email, :string
  end
end
