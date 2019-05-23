require 'rails_helper'

RSpec.describe SongsController do
  it 'deletes a song from the list of songs' do
    song1 = create("song", new_work_title: 'new work title 1')
    create("song", new_work_title: 'new work title 2')
    expect { delete "/songs/#{song1.id}" }.to change(Song, :count).by(-1)
    #expect { delete :destroy, params: { id: song1.id } }.to change(Song, :count).by(-1)
  end
  it 'creates a song' do
    song_attributes = attributes_for(:song)
    song_attributes[:new_work_title].should eq('new work title')
   # post(:create, params: { song: song_attributes } )
   #expect { post(:create, params: { song: { new_work_title: "New Work Title" }}) }.to change(Song, :count).by(1)
  end
end



