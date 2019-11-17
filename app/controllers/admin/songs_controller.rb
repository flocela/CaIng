class Admin::SongsController < ApplicationController

  def index
    if current_admin && current_admin.email == Rails.application.credentials[:admin_email]
      @songs = Song.all
    else
      redirect_to(new_admin_session_path, alert: "Access denied.")
    end
  end
  
  def new
    if current_admin && current_admin.email == Rails.application.credentials[:admin_email]
      @songs = Song.all
      @song = Song.new()
    else
      redirect_back(fallback_location: new_admin_session_path, method: :delete, alert: "Access denied.")
    end
  end
  
  def create
    if current_admin && current_admin.email == Rails.application.credentials[:admin_email]
      song = Song.new(song_params)
      song.save!
      redirect_to(admin_songs_path)
    else
      redirect_back(fallback_location: new_admin_session_path, method: :delete, alert: "Access denied.")
    end
  end
  
  def edit
    if current_admin && current_admin.email == Rails.application.credentials[:admin_email]
      if (!params[:id].scan(/\D/).empty?)
	flash[:notice] = 'that is not an integer'
	redirect_to(admin_songs_path)
      else 
	@song = Song.find_by_id(params[:id])
      end 
    else
      redirect_back(fallback_location: new_admin_session_path, method: :delete, alert: "Access denied.")
    end
  end 

  def update 
    if current_admin && current_admin.email == Rails.application.credentials[:admin_email]
      if (!params[:id].scan(/\D/).empty?)
	flash[:notice] = 'that is not an integer'
	redirect_to(admin_songs_path)
      else
	song = Song.find_by_id(params[:id])
	song.update!(song_params)
      end
    else
      redirect_back(fallback_location: new_admin_session_path, method: :delete, alert: "Access denied.")
    end
  end

  def destroy
    if current_admin && current_admin.email == Rails.application.credentials[:admin_email]
      if (!params[:id].scan(/\D/).empty?)
	flash[:notice] = 'that is not an integer'
	redirect_to(admin_songs_path)
      else
	song = Song.find_by_id(params[:id])
	song.destroy
      end
    else
      redirect_back(fallback_location: new_admin_session_path, method: :delete, alert: "Access denied.")
    end
  end

  def song_params
    params.require(:song).permit(:new_work_title, 
                                 :song_type, 
                                 :orig_english_title, 
                                 :orig_artist,
                                 :orig_downloaded_at_name,
                                 :orig_downloaded_at_link,
                                 :orig_pub_date,
                                 :orig_lyrics_date,
                                 :orig_lyrics_date_link_name,
                                 :orig_license_name,
                                 :orig_license_link, 
                                 :orig_attribution_link, 
                                 :orig_uses_sample_from_link_name_1,
                                 :orig_uses_sample_from_link_1, 
                                 :orig_english_uses_sample_from_1,
                                 :orig_spanish_uses_sample_from_1,
                                 :name_of_new_work_license, 
                                 :link_to_new_work_license,
                                 :orig_english_changes_made,
                                 :orig_spanish_changes_made,
                                 :filename,
                                 :zip_size)
  end


end
