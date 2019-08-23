require 'aws-sdk'
class SongsController < ApplicationController
  def index
    @songs = Song.all
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
    if (DownloadCount.where(:month => Date.current.beginning_of_month).sum(:month_total) > 500)
      flash[:notice] = "Already have 500 downloads"
      redirect_to(songs_path)  
    else 
      access_key_id = Rails.application.credentials.development[:aws][:access_key_id]
      secret_access_key = Rails.application.credentials.development[:aws][:secret_access_key]
      s3 = Aws::S3::Resource.new(region: 'us-east-1', access_key_id: access_key_id, secret_access_key: secret_access_key)
      filename = Song.find(params[:id]).filename << ".zip"
      s3_file_path ="m4a/#{filename}"
      object = s3.bucket('cantandoinglesbucket').object(s3_file_path)
      object.get(response_target: "#{Rails.root}/app/assets/songs/#{filename}")
      File.chmod(0666, "#{Rails.root}/app/assets/songs/#{filename}")
      send_file "app/assets/songs/#{filename}", :filename => "#{filename}", :url_based_filename => false, :type=>"application/zip"
      song = Song.find(params[:id])
      downloadCount = DownloadCount.find_by(song_id: 19, month: Date.current.beginning_of_month)
      if (downloadCount)
        downloadCount.month_total = downloadCount.month_total + 1
        downloadCount.save
      else
        newDownloadCount = DownloadCount.new(:song_id => song.id, month: Date.current.beginning_of_month, :month_total => 1)
        newDownloadCount.save
      end
      File.delete('app/assets/songs/${filename}') if File.exists?('app/assets/songs/#{filename}')
    end
  end

end
