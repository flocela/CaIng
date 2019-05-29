class Admin::SongsController < ApplicationController
  before_action :authenticate_admin!
  def index
    unless current_admin
      redirect_to :back, :alert => "Access denied."
    end
    @songs = Song.all
  end
  def new
    unless current_admin
      redirect_to :back, :alert => "Access denied."
    end
   @song = Song.new()
  end
  def create
    unless current_admin
      redirect_to :back, :alert => "Access denied."
    end
    song = Song.new(song_params)
    song.save!
    redirect_to(admin_songs_path)
  end
  def destroy
    unless current_admin
      redirect_to :back, :alert => "Access denied."
    end
    song = Song.find(params[:id])
    song.destroy
    redirect_to admin_songs_path
  end  
  def song_params
    params.require(:song).permit(:new_work_title, :song_type, :orig_english_title, :orig_artist, :orig_downloaded_at_name, :orig_downloaded_at_link, :orig_license_name, :orig_license_link, :name_of_new_work_license, :link_to_new_work_license, :filename)
  end
end

