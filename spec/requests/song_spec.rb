require 'rails_helper'

RSpec.describe "Song" do
  it 'deletes a song from the list of songs' do
    song1 = create("song", new_work_title: 'new work title 1')
    create("song", new_work_title: 'new work title 2')
    expect { delete "/songs/#{song1.id}" }.to change(Song, :count).by(-1)
    #expect { delete :destroy, params: { id: song1.id } }.to change(Song, :count).by(-1)
  end
end
