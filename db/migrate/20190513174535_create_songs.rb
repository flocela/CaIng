class CreateSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.string :new_work_title, null:false, unique: true
      t.integer :song_type, null:false
      t.string :orig_english_title, null:false
      t.string :orig_artist, null:false
      t.string :orig_downloaded_at_name, null:false
      t.string :orig_downloaded_at_link, null:false
      t.string :orig_pub_date
      t.string :orig_lyrics_date
      t.string :orig_lyrics_date_link_name
      t.string :orig_lyrics_date_link
      t.string :orig_license_name, null:false
      t.string :orig_license_link, null:false
      t.text :orig_attribution_link
      t.string :orig_uses_sample_from_link_name_1
      t.string :orig_uses_sample_from_link_1
      t.string :orig_english_uses_sample_from_1
      t.string :orig_spanish_uses_sample_from_1
      t.string :name_of_new_work_license, null:false
      t.string :link_to_new_work_license, null:false
      t.string :orig_english_changes_made
      t.string :orig_spanish_changes_mande
      t.string :filename, null:false
      t.string :zip_size

      t.timestamps 
    end
  end
end
