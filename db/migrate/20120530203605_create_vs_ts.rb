class CreateVsTs < ActiveRecord::Migration
  def change
    create_table :vs_ts do |t|
      t.string :name
      t.string :sources

      t.timestamps
    end
  end
end
