# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_06_22_204734) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_tokens", force: :cascade do |t|
    t.bigint "user_id"
    t.string "token", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_access_tokens_on_user_id"
  end

  create_table "activs", force: :cascade do |t|
    t.bigint "user_id"
    t.date "item", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_activs_on_user_id"
  end

  create_table "tracks", force: :cascade do |t|
    t.bigint "activ_id", null: false
    t.string "name", null: false
    t.integer "distance", null: false
    t.integer "duration", null: false
    t.integer "repeat", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["activ_id"], name: "index_tracks_on_activ_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "encrypted_password"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "access_tokens", "users"
  add_foreign_key "activs", "users"
  add_foreign_key "tracks", "activs"
end
