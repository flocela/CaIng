require 'aws-sdk'
class SongsController < ApplicationController
  def index
  end

  def get_zip
    song = Song.find_by_id(params[:id])
    send_song_from_aws(song)
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

end
