class CreateUserProductions < ActiveRecord::Migration
  def change
    create_table :user_productions, :id => false do |t|
      t.integer :user_id
      t.integer :production_id

      t.timestamps
    end
    add_index :user_productions, [:user_id, :production_id], :unique => true
  end
end
