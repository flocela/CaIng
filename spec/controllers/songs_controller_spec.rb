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
    create("download_count", song_id:1, month: Time.parse("2019-08-01"), month_total:500)
    create("song", id:2, filename: 'act_cool_loveshadow')
    expect_any_instance_of(SongsController).to receive(:send_file).with('app/assets/songs/act_cool_loveshadow.zip', :filename => 'act_cool_loveshadow.zip', :url_based_filename => false, :type => 'application/zip').and_call_original
    get :get_zip, params: {id:2}
    File.delete('app/assets/songs/act_cool_loveshadow.zip') 
   
    expect_any_instance_of(SongsController).not_to receive(:send_file).with('app/assets/songs/act_cool_loveshadow.zip', :filename => 'act_cool_loveshadow.zip', :url_based_filename => false, :type => 'application/zip').and_call_original
    get :get_zip, params: {id:2}
    File.delete('app/assets/songs/act_cool_loveshadow.zip') if File.exists?('app/assets/songs/act_cool_loveshadow.zip')
  end 
end
