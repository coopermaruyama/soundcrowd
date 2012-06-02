class RemoveProgramFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :program
      end

  def down
    add_column :users, :program, :integer
  end
end
