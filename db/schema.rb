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

ActiveRecord::Schema.define(version: 20170801203636) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "fname"
    t.string "lname"
    t.string "email"
    t.string "username"
    t.string "password"
    t.string "img_src"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "counties", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "county_trails", force: :cascade do |t|
    t.bigint "county_id"
    t.bigint "trail_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["county_id"], name: "index_county_trails_on_county_id"
    t.index ["trail_id"], name: "index_county_trails_on_trail_id"
  end

  create_table "photos", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "trail_id"
    t.string "caption"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trail_id"], name: "index_photos_on_trail_id"
    t.index ["user_id"], name: "index_photos_on_user_id"
  end

  create_table "reports", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "surface_rating"
    t.integer "traffic_rating"
    t.integer "scenery_rating"
    t.integer "overall_rating"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_reports_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "category_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trail_reports", force: :cascade do |t|
    t.bigint "trail_id"
    t.bigint "report_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["report_id"], name: "index_trail_reports_on_report_id"
    t.index ["trail_id"], name: "index_trail_reports_on_trail_id"
  end

  create_table "trail_tags", force: :cascade do |t|
    t.bigint "trail_id"
    t.bigint "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_id"], name: "index_trail_tags_on_tag_id"
    t.index ["trail_id"], name: "index_trail_tags_on_trail_id"
  end

  create_table "trails", force: :cascade do |t|
    t.integer "csv_id"
    t.string "name"
    t.float "length"
    t.string "surface"
    t.float "surface_rating"
    t.float "traffic_rating"
    t.float "scenery_rating"
    t.float "overall_rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "fname"
    t.string "lname"
    t.string "email"
    t.string "username"
    t.string "password"
    t.string "img_src"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "county_trails", "counties"
  add_foreign_key "county_trails", "trails"
  add_foreign_key "photos", "trails"
  add_foreign_key "photos", "users"
  add_foreign_key "reports", "users"
  add_foreign_key "trail_reports", "reports"
  add_foreign_key "trail_reports", "trails"
  add_foreign_key "trail_tags", "tags"
  add_foreign_key "trail_tags", "trails"
end
