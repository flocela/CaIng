require 'rails_helper'

RSpec.describe SongsController do
  it 'increases monthly downloads on song ' do
    song = create("song", id:19, filename: 'act_cool_loveshadow.zip')
    get :get_zip, params: {id:19}
    expect(DownloadCount.find_by(song_id:19).month_total).to eq(1)
    get :get_zip, params: {id:19}
    expect(DownloadCount.find_by(song_id:19).month_total).to eq(2)
  end  
end
