require 'rails_helper'

RSpec.describe Admin::SongsController do 
# SongsController defines the controller. This test must be inside /controllers or /requests directories. Maybe, file also must be named songs_controller.
  it 'deletes a song from the list of songs' do
    admin = Admin.create!(email: "flocela@gmail.com", password: "very-secret", password_confirmation: "very-secret")
    sign_in admin
    song1 = create("song", new_work_title: 'new work title 1')
    expect(Song.count).to eq(1)
    create("song", new_work_title: 'new work title 2')
    expect(Song.count).to eq(2)
    expect { delete :destroy, params: { id: song1.id } }.to change(Song, :count).by(-1)
  end

  it 'does not allow an unconfirmed admin to delete a song' do
    admin = Admin.create!(email: "flocela@gmail.com", password: "very-secret", password_confirmation: "very-secret")
    sign_in admin
    song1 = create("song", new_work_title: 'new work title 1')
    expect(Song.count).to eq(1)
    create("song", new_work_title: 'new work title 2')
    expect(Song.count).to eq(2)
    sign_out admin
    expect { delete :destroy, params: { id: song1.id } }.to change(Song, :count).by(0)
  end

  it 'creates a song when admin is signed in' do
    song_attributes = attributes_for(:song)
    song_attributes[:new_work_title].should eq('new work title')
    admin = Admin.create!(email: "flocela@gmail.com", password: "very-secret", password_confirmation: "very-secret")
    sign_in admin
    expect { post(:create, params: { song: song_attributes}) }.to change(Song, :count).by(1)
  end

  it 'does not create a song when admin is not signed in' do
    song_attributes = attributes_for(:song)
    song_attributes[:new_work_title].should eq('new work title')
    admin = Admin.create!(email: "flocela@gmail.com", password: "very-secret", password_confirmation: "very-secret")
    expect { post(:create, params: { song: song_attributes}) }.to change(Song, :count).by(0)
  end
end
