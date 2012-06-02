class AddProgramidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :program_id, :integer

  end
end
