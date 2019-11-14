class Song < ActiveRecord::Base

  validates :new_work_title, presence: true
  validates :song_type, presence: true
  validates :orig_english_title, presence: true
  validates :orig_artist, presence: true
  validates :orig_downloaded_at_name, presence: true
  validates :orig_downloaded_at_link, presence: true
  validates :orig_license_name, presence: true
  validates :orig_license_link, presence: true
  validates :name_of_new_work_license, presence: true
  validates :link_to_new_work_license, presence: true
  validates :orig_english_changes_made, presence: true
  validates :orig_spanish_changes_made, presence: true
  validates :filename, presence: true
  validates :zip_size, presence: true

end
