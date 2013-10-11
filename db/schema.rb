# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20131009233314) do

  create_table "boards", :force => true do |t|
    t.string   "title",      :null => false
    t.integer  "creator_id", :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "boards", ["creator_id"], :name => "index_boards_on_creator_id"

  create_table "cards", :force => true do |t|
    t.string   "title",       :null => false
    t.string   "description"
    t.datetime "due_date"
    t.integer  "catagory_id", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "cards", ["catagory_id"], :name => "index_cards_on_catagory_id"

  create_table "catagories", :force => true do |t|
    t.string   "title"
    t.integer  "board_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "catagories", ["board_id"], :name => "index_catagories_on_board_id"
  add_index "catagories", ["title", "board_id"], :name => "index_catagories_on_title_and_board_id", :unique => true

  create_table "checklist_items", :force => true do |t|
    t.string   "title",        :null => false
    t.integer  "checklist_id", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "checklist_items", ["checklist_id"], :name => "index_checklist_items_on_card_id"

  create_table "checklists", :force => true do |t|
    t.integer  "card_id",                             :null => false
    t.string   "title",      :default => "Checklist", :null => false
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  add_index "checklists", ["card_id"], :name => "index_checklists_on_card_id"

  create_table "memberships", :force => true do |t|
    t.integer  "user_id",                       :null => false
    t.integer  "board_id",                      :null => false
    t.boolean  "admin",      :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "memberships", ["board_id"], :name => "index_memberships_on_board_id"
  add_index "memberships", ["user_id", "board_id"], :name => "index_memberships_on_user_id_and_board_id", :unique => true
  add_index "memberships", ["user_id"], :name => "index_memberships_on_user_id"

  create_table "participations", :force => true do |t|
    t.integer  "card_id",    :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "participations", ["card_id", "user_id"], :name => "index_participations_on_card_id_and_user_id", :unique => true
  add_index "participations", ["card_id"], :name => "index_participations_on_card_id"
  add_index "participations", ["user_id"], :name => "index_participations_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",           :null => false
    t.string   "password_digest", :null => false
    t.string   "username"
    t.string   "bio"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["token"], :name => "index_users_on_token"

end
