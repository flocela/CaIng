require 'rails_helper'

RSpec.describe Admin::SongsController do 
# SongsController defines the controller. This test must be inside /controllers or /requests directories. Maybe, file also must be named songs_controller.
  it 'deletes a song from the list of songs' do
    song1 = create("song", new_work_title: 'new work title 1')
    create("song", new_work_title: 'new work title 2')
    # TODO this doesn't work, why?? expect { delete "/songs/#{song1.id}" }.to change(Song, :count).by(-1)
    expect { delete :destroy, params: { id: song1.id } }.to change(Song, :count).by(-1)
  end
  it 'creates a song' do
    song_attributes = attributes_for(:song)
    song_attributes[:new_work_title].should eq('new work title')
    expect { post(:create, params: { song: song_attributes}) }.to change(Song, :count).by(1)
  end
end
