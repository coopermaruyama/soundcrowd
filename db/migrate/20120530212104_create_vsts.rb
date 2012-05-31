class CreateVsts < ActiveRecord::Migration
  def change
    create_table :vsts do |t|
      t.string :name
      t.string :source

      t.timestamps
    end
  end
end
