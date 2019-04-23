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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_04_05_105508) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "label_task_lists", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "label_id", null: false
    t.uuid "task_list_id", null: false
    t.index ["label_id", "task_list_id"], name: "index_label_task_lists_on_label_id_and_task_list_id", unique: true
    t.index ["label_id"], name: "index_label_task_lists_on_label_id"
    t.index ["task_list_id"], name: "index_label_task_lists_on_task_list_id"
  end

  create_table "label_tasks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "label_id", null: false
    t.uuid "task_id", null: false
    t.index ["label_id", "task_id"], name: "index_label_tasks_on_label_id_and_task_id", unique: true
    t.index ["label_id"], name: "index_label_tasks_on_label_id"
    t.index ["task_id"], name: "index_label_tasks_on_task_id"
  end

  create_table "labels", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.uuid "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_labels_on_user_id"
  end

  create_table "task_lists", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "status", null: false
    t.text "description"
    t.uuid "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_task_lists_on_user_id"
  end

  create_table "tasks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "status", null: false
    t.uuid "task_list_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_list_id"], name: "index_tasks_on_task_list_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", null: false
    t.string "auth_token", null: false
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["auth_token"], name: "index_users_on_auth_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "label_task_lists", "labels", on_delete: :cascade
  add_foreign_key "label_task_lists", "task_lists", on_delete: :cascade
  add_foreign_key "label_tasks", "labels", on_delete: :cascade
  add_foreign_key "label_tasks", "tasks", on_delete: :cascade
  add_foreign_key "labels", "users", on_delete: :cascade
  add_foreign_key "task_lists", "users", on_delete: :cascade
  add_foreign_key "tasks", "task_lists", on_delete: :cascade
end
