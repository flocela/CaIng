require 'aws-sdk'
class SongsController < ApplicationController
  def index
  end

  def get_zip
    if (DownloadCount.where(:month => first_of_month).sum(:month_total) >= 500)
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
  
  def aws_key_id
    Rails.application.credentials.development[:aws][:access_key_id]
  end

  def aws_secret_access_key
      Rails.application.credentials.development[:aws][:secret_access_key]
  end

end
