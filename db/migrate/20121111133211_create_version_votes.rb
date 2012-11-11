class CreateVersionVotes < ActiveRecord::Migration
  def change
    create_table :version_votes do |t|
      t.integer :user_id
      t.integer :version_id

      t.timestamps
    end
  end
end
