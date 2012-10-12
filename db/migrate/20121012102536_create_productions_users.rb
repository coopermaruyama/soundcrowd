class CreateProductionsUsers < ActiveRecord::Migration
  def change
    create_table :productions_users, :id => false do |t|
		t.references :production, :null => false
		t.references :user, :null => false
    end

    
  end

end
