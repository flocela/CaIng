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
    access_key_id = Rails.application.credentials[Rails.env.to_sym][:aws][:access_key_id]
    secret_access_key = Rails.application.credentials[Rails.env.to_sym][:aws][:secret_access_key]
    s3 = Aws::S3::Resource.new(region: 'us-east-1', access_key_id: access_key_id, secret_access_key: secret_access_key)
    filename = Song.find(params[:id]).filename + '.zip';
    s3_file_path ="m4a/#{filename}"
    object = s3.bucket('cantandoinglesbucket').object(s3_file_path)
    object.get(response_target: "#{Rails.root}/app/assets/songs/#{filename}")
    File.chmod(0666, "#{Rails.root}/app/assets/songs/#{filename}")
    send_file "#{Rails.root}/app/assets/songs/#{filename}", :filename => "#{filename}", :url_based_filename => false, :type=>"application/zip"
  end
=begin

      s3_file_path ="m4a/#{filename}.zip"
      temp_dir_name ="#{Rails.root}/public/system/songs/temp_m4a"

      temp_base_file_name = File.basename(s3_file_path)
      full_temp_filename = "#{temp_dir_name}/#{temp_base_file_name}"
      if File.exists?("#{full_temp_filename}")
        File.delete("#{full_temp_filename}")
      end
      unless File.directory?("#{temp_dir_name}")
        FileUtils.mkdir_p("#{temp_dir_name}")
      end
      File.open("#{full_temp_filename}", "wb") do |f|
        f.write(bucket.objects["#{s3_file_path}"].read)
      end
      File.chmod(0666, "#{full_temp_filename}")
      send_file "#{full_temp_filename}",:filename => "#{temp_base_file_name}",:url_based_filename => false, :type=>"application/zip"

      @song = Song.find(songid)
      downloadhash = Hash.new
      downloadhash["song_id"]=songid;
      @download = @song.downloads.build(downloadhash)
      @download.save
      @today = Date.today
      @beginning_of_month = @today.beginning_of_month
      @this_months_downloads = Download.where(:created_at => @beginning_of_month.beginning_of_day..@today.end_of_day)
      
      if (@this_months_downloads.length>200 && @this_months_downloads.length<202)
        Notifier.num_downloads(@this_months_downloads.length).deliver
=end

  def dealWithDownloads
   @today = Date.today
    @beginning_of_month = @today.beginning_of_month
    @this_months_downloads = Download.where(:created_at => @beginning_of_month.beginning_of_day..@today.end_of_day)
    if (@this_months_downloads.length>3999 && this.months_downloads.length<4001)
      Notifier.num_downloads(@this_months_downloads.length).deliver
    end
    if (@this_months_downloads.length>4999 && this.months_downloads.length<5001)
      Notifier.num_downloads(@this_months_downloads.length).deliver
    end
    if (@this_months_downloads.length>4999)
      flash[:notice] = "Already have 5000 downloads"
    end

  end
=begin
  def index
    @songs = Song.all
    respond_to do |format|
      format.html
      format.xml {render :xml => 
        @songs.to_xml( :only => [:id, 
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
                                 :zip_size 
                                ])}
    end
  end
=end
end
