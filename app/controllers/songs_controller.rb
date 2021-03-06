require 'aws-sdk'
class SongsController < ApplicationController
  helper_method :monthly_downloads_exist
  helper_method :monthly_download_count
  helper_method :total_downloads_this_month
  def index
    @songs = Song.order(:song_type)
    respond_to do |format|
      format.html
      format.xml {render :xml =>
                         @songs.map(&:as_json).to_xml(:only => [
                                 :id,
                                 :filename, 
                                 :link_to_new_work_license, 
                                 :name_of_new_work_license,
                                 :new_work_title, 
                                 :orig_attribution_link,
                                 :orig_artist,
                                 :orig_downloaded_at_link,
                                 :orig_downloaded_at_name,
                                 :orig_english_changes_made, 
                                 :orig_english_uses_sample_from_1, 
                                 :orig_english_title, 
                                 :orig_license_link, 
                                 :orig_license_name, 
                                 :orig_lyrics_date,
                                 :orig_lyrics_date_link,
                                 :orig_lyrics_date_link_name,
                                 :orig_pub_date,
                                 :orig_spanish_changes_made,
                                 :orig_spanish_uses_sample_from_1, 
                                 :orig_uses_sample_from_link_1,
                                 :orig_uses_sample_from_link_name_1,
                                 :song_type, 
                                 :zip_size]  )}
    end
  end

  def get_zip
    if (DownloadCount.where(:month => first_of_month).sum(:month_total) > 500)
      flash[:notice] = "Already have 500 downloads"
      redirect_to(songs_path)  
    elsif (!params[:id].scan(/\D/).empty?)
      flash[:notice] = "that is not an integer"
      redirect_to(songs_path)
    else
      song = Song.find_by_id(params[:id])
      send_song_from_aws(song)
      update_download_count(song)
    end
  end

  private

  def send_song_from_aws(song)  
      s3 = Aws::S3::Resource.new(region: 'us-east-1', 
                                 access_key_id: aws_key_id, 
                                 secret_access_key: aws_secret_access_key)
      filename = song.filename + ".zip" 
      filepath = "#{Rails.root}/app/assets/songs/#{filename}" 
      s3_file_path ="m4a/#{filename}"
      object = s3.bucket('cantandoinglesbucket').object(s3_file_path)
      object.get(response_target: filepath)
      File.chmod(0666, filepath)
      send_file filepath, 
                :filename => "#{filename}", 
                :url_based_filename => false, 
                :type=>"application/zip"
      File.delete(filepath) if(File.exists?(filepath))
  end

  def update_download_count(song) 
      downloadCountObj = DownloadCount.find_by(song_id: song.id, 
                                               month: first_of_month)
      if (downloadCountObj)
	downloadCountObj.month_total = downloadCountObj.month_total + 1
	downloadCountObj.save
      else
	newDownloadCountObj = DownloadCount.new(:song_id => song.id, 
                                             month: first_of_month, 
                                             :month_total => 1)
	newDownloadCountObj.save
      end
  end 

  def first_of_month
    Date.current.beginning_of_month
  end

  def monthly_download_count(song_id_x) 
    downloadCount = DownloadCount.find_by(song_id: song_id_x)
    if (downloadCount)
      downloadCount.month_total
    else
    end
  end    

  def total_downloads_this_month
    DownloadCount.where(:month => first_of_month).sum(:month_total)  
  end

  def aws_key_id
    Rails.application.credentials.development[:aws][:access_key_id]
  end

  def aws_secret_access_key
      Rails.application.credentials.development[:aws][:secret_access_key]
  end
    
end
