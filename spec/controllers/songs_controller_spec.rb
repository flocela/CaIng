require 'rails_helper'

describe SongsController do

  describe 'when calling get_zip action ' do
 
    it 'Song.find is called if :id is an integer' do
      create("song", id:19, filename: 'act_cool_loveshadow')
      expect(Song).to receive(:find_by_id).and_call_original
      get :get_zip, params: {id:19}       
    end 

    it 'Song.find is not called if :id is not an integer' do
      create("song", id:19, filename: 'act_cool_loveshadow')
      expect(Song).to_not receive(:find_by_id).and_call_original
      get :get_zip, params: {"id":"19a"}
    end   

    it 'shows flash notice if :id is not an integer' do
      create("song", 
	     new_work_title: 'amazing_grace_download', 
	     id: 15, 
	     filename: 'amazing_grace_rich_tuttle')
      get :get_zip, params: {"id":"15a"} 
      expect(flash[:notice]).to match('that is not an integer')
    end   
    
    it "increases a song's monthly download count when the song is downloaded" do
      song = create("song", id:19, filename: 'act_cool_loveshadow')
      get :get_zip, params: {id:19}
      expect(DownloadCount.find_by(song_id:19).month_total).to eq(1)
      get :get_zip, params: {id:19}
      expect(DownloadCount.find_by(song_id:19).month_total).to eq(2)
    end
    
    it 'does not download more than 500 songs in a month' do
      create("download_count", 
             month: Time.parse("2019-07-01"), 
             month_total:400)
      create("download_count", 
             month: Date.current.beginning_of_month, 
             month_total:499)
      create("song", id:2, filename: 'act_cool_loveshadow')
      filepath = "#{Rails.root}/app/assets/songs/act_cool_loveshadow.zip" 
   
      expect_any_instance_of(SongsController).to receive(:send_file)
	.with(filepath,
	      :filename => 'act_cool_loveshadow.zip',
	      :url_based_filename => false,
	      :type => 'application/zip')
	.and_call_original
	get :get_zip, params: {id:2}
      
      expect_any_instance_of(SongsController).not_to receive(:send_file)
	.with(filepath,
  	      :filename => 'act_cool_loveshadow.zip',
	      :url_based_filename => false, 
	      :type => 'application/zip')
	.and_call_original
      get :get_zip, params: {id:2}
    end 

  end

end
