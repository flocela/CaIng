class Admin::SongsController < ApplicationController
  before_action :authenticate_admin!
  def index
    if current_admin 
      @songs = Song.all
    else
      redirect_back(fallback_location: admin_session_path, alert: "Access denied.")
     #redirect_to :back, :alert => "Access denied."
    end
  end
  def new
    if current_admin && current_admin.email == Rails.application.credentials.development[:admin_email]
      @songs = Song.all
      @song = Song.new()
      #redirect_to :back, :alert => "Access denied."
    else
      redirect_back(fallback_location: admin_session_path, method: :delete, alert: "Access denied.")
    end
  end
  def create
    if current_admin && current_admin.email == Rails.application.credentials.development[:admin_email]
      @songs = Song.all
      song = Song.new(song_params)
      song.save!
      redirect_to(admin_songs_path)
    else
      redirect_back(fallback_location: admin_session_path, method: :delete, alert: "Access denied.")
    end
  end
  def destroy
    if current_admin && current_admin.email == Rails.application.credentials.development[:admin_email]
      @songs = Song.all
      song = Song.find(params[:id])
      song.destroy
      redirect_to admin_songs_path
    else
      redirect_back(fallback_location: admin_session_path, method: :delete, alert: "Access denied.")
    end
  end  
  def song_params
    params.require(:song).permit(:new_work_title, :song_type, :orig_english_title, :orig_artist, :orig_downloaded_at_name, :orig_downloaded_at_link, :orig_license_name, :orig_license_link, :name_of_new_work_license, :link_to_new_work_license, :filename)
  end
end

