class Admin::SongsController < ApplicationController
  
  def new
  end
  
  def edit
  end 

  def create
    song = Song.new(song_params)
    song.save!
  end

  def update 
    song = Song.find(params[:id])
    song.update!(song_params)
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
