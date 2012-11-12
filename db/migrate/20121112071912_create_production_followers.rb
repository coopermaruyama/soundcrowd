class CreateProductionFollowers < ActiveRecord::Migration
  def change
    create_table :production_followers do |t|
      t.integer :user_id
      t.integer :production_id

      t.timestamps
    end
  end
end
