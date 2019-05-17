class SongController < ApplicationController
  def index
    @songs = Song.all
  end
  def new
  end
  def create
    song = Song.new(song_params)
    song.save!
    redirect_to(songs_path)
  end
  def song_params
    params.require(:song).permit(:new_work_title, :song_type, :orig_english_title, :orig_artist, :orig_downloaded_at_name, :orig_downloaded_at_link, :orig_license_name, :orig_license_link, :name_of_new_work_license, :link_to_new_work_license, :filename)
  end
end

