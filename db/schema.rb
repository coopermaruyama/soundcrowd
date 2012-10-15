#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121014115630) do

  create_table "productions", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "creator_id"
  end

  create_table "user_productions", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.integer  "production_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "user_productions", ["user_id", "production_id"], :name => "index_user_productions_on_user_id_and_production_id", :unique => true

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "source_file"
    t.string   "audio_file"
    t.integer  "production_id"
    t.integer  "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "title"
    t.string   "ancestry"
  end

  add_index "versions", ["ancestry"], :name => "index_versions_on_ancestry"
  add_index "versions", ["production_id"], :name => "index_versions_on_production_id"
  add_index "versions", ["user_id", "production_id"], :name => "index_versions_on_user_id_and_production_id"
  add_index "versions", ["user_id"], :name => "index_versions_on_user_id"

end
