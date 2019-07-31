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

ActiveRecord::Schema.define(version: 2019_07_31_202731) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "download_counts", force: :cascade do |t|
    t.integer "song_id"
    t.date "month"
    t.integer "month_total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "songs", force: :cascade do |t|
    t.string "new_work_title", null: false
    t.integer "song_type", null: false
    t.string "orig_english_title", null: false
    t.string "orig_artist", null: false
    t.string "orig_downloaded_at_name", null: false
    t.string "orig_downloaded_at_link", null: false
    t.string "orig_pub_date"
    t.string "orig_lyrics_date"
    t.string "orig_lyrics_date_link_name"
    t.string "orig_lyrics_date_link"
    t.string "orig_license_name", null: false
    t.string "orig_license_link", null: false
    t.text "orig_attribution_link"
    t.string "orig_uses_sample_from_link_name_1"
    t.string "orig_uses_sample_from_link_1"
    t.string "orig_english_uses_sample_from_1"
    t.string "orig_spanish_uses_sample_from_1"
    t.string "name_of_new_work_license", null: false
    t.string "link_to_new_work_license", null: false
    t.string "orig_english_changes_made"
    t.string "orig_spanish_changes_made"
    t.string "filename", null: false
    t.string "zip_size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["new_work_title"], name: "index_songs_on_new_work_title", unique: true
  end

end
