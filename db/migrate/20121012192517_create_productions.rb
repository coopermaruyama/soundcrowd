class CreateProductions < ActiveRecord::Migration
  def change
    create_table :productions do |t|
      t.string :title
      
      t.timestamps
    end
  end
end
