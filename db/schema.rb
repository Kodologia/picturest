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

ActiveRecord::Schema.define(version: 20160803100046) do

  create_table "photos", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "image"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "user_id"
    t.integer  "ratings_count", default: 0, null: false
    t.integer  "ratings_sum",   default: 0, null: false
  end

  create_table "photos_users", force: :cascade do |t|
    t.integer "photo_id"
    t.integer "user_id"
    t.index ["photo_id", "user_id"], name: "index_photos_users_on_photo_id_and_user_id", unique: true
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "value"
    t.integer  "user_id"
    t.integer  "photo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "photo_id"], name: "index_ratings_on_user_id_and_photo_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
