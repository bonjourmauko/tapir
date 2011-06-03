# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110602213611) do

  create_table "books", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "language"
    t.string   "paypal_username"
    t.decimal  "price",           :precision => 6, :scale => 2
    t.boolean  "free"
    t.string   "author"
  end

  create_table "illustrations", :force => true do |t|
    t.string   "original_url"
    t.integer  "book_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "external_id"
    t.string   "content_type"
  end

  create_table "images", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "masters", :force => true do |t|
    t.string   "guid"
    t.integer  "book_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "premaster_packets", :force => true do |t|
    t.string   "premaster_guid"
    t.string   "client_timestamp"
    t.integer  "position"
    t.integer  "length"
    t.text     "chunk"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "premasters", :force => true do |t|
    t.string   "guid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "book_id"
    t.boolean  "uploaded"
  end

  create_table "sources", :force => true do |t|
    t.boolean  "collection"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "book_id"
    t.string   "service"
    t.string   "resource_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "authentication_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
