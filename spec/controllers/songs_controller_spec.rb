require 'rails_helper'

RSpec.describe SongsController do
  it 'increases monthly downloads on song ' do
    song = create("song", id:19, filename: 'act_cool_loveshadow')
    get :get_zip, params: {id:19}
    expect(DownloadCount.find_by(song_id:19).month_total).to eq(1)
    get :get_zip, params: {id:19}
    expect(DownloadCount.find_by(song_id:19).month_total).to eq(2)
  end
  
  it 'monthly download total for all songs correct' do
    create("download_count", song_id:1, month: Time.parse("2019-07-01"), month_total:4)
    create("download_count", song_id:1, month: Time.parse("2019-08-01"), month_total:3)
    create("download_count", song_id:2, month: Time.parse("2019-07-01"), month_total:5)
    create("download_count", song_id:2, month: Time.parse("2019-08-01"), month_total:8)
    expect(DownloadCount.where(:month => Time.parse("2019-08-01")).sum(:month_total)).to equal(11)
  end
  
  it 'does not download more than 500 songs in a month' do
    create("download_count", song_id:1, month: Time.parse("2019-07-01"), month_total:400)
    create("download_count", song_id:1, month: Time.parse("2019-09-01"), month_total:500)
    create("song", id:2, filename: 'act_cool_loveshadow')
    expect_any_instance_of(SongsController).to receive(:send_file).with('app/assets/songs/act_cool_loveshadow.zip', :filename => 'act_cool_loveshadow.zip', :url_based_filename => false, :type => 'application/zip').and_call_original
    get :get_zip, params: {id:2}
    File.delete('app/assets/songs/act_cool_loveshadow.zip') 
   
    expect_any_instance_of(SongsController).not_to receive(:send_file).with('app/assets/songs/act_cool_loveshadow.zip', :filename => 'act_cool_loveshadow.zip', :url_based_filename => false, :type => 'application/zip').and_call_original
    get :get_zip, params: {id:2}
    File.delete('app/assets/songs/act_cool_loveshadow.zip') if File.exists?('app/assets/songs/act_cool_loveshadow.zip')
  end 
    
  it 'shows flash notice if params id is not an integer' do
    create("song", new_work_title: 'amazing_grace_download', id: 15, filename: 'amazing_grace_rich_tuttle')
    get :get_zip, params: {"id":"15a"} 
    expect(flash[:notice]).to match('that is not an integer')
    File.delete('app/assets/songs/amazing_grace_download.zip') if File.exists?('app/assets/songs/amazing_grace_download.zip')
  end   
  
  it 'Song.find is called if :id an integer' do
    create("song", id:19, filename: 'act_cool_loveshadow')
    expect(Song).to receive(:find_by_id).and_call_original
    get :get_zip, params: {id:19}
    
    File.delete('app/assets/songs/act_cool_loveshadow.zip') if File.exists?('app/assets/songs/act_cool_loveshadow.zip')

  end   
  
  it 'Song.find is not called if :id is not an integer' do
    create("song", id:19, filename: 'act_cool_loveshadow')
    expect(Song).to_not receive(:find_by_id).and_call_original
    get :get_zip, params: {"id":"19a"}
    
    File.delete('app/assets/songs/act_cool_loveshadow.zip') if File.exists?('app/assets/songs/act_cool_loveshadow.zip')

  end   
  
end
