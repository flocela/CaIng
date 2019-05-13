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

ActiveRecord::Schema.define(version: 2019_05_13_174535) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
  end

end
