require 'rails_helper'
require 'admin/songs_controller' #otherwise routes will default to /songs.

describe Admin::SongsController do 

  describe 'flocela signs in as admin, and ' do

    before(:each) do
      admin = create('admin', email: 'flocela@gmail.com')
      sign_in admin
    end

    it 'is allowed to open admin/songs/index' do
      get :index
      expect(response).to render_template("index")
    end 
    
    it 'is allowed to open admin/songs/new' do
      get :new
      expect(response).to render_template("new")
    end 

    it 'is allowed to open admin/songs/edit' do
      song = create("song")
      get :edit, params: {id: song.id}
      expect(response).to render_template("edit")
    end 

    it 'is allowed to create a song' do
      song_attributes = attributes_for(:song)
      expect {post(:create, params: {song: song_attributes})}
        .to change(Song, :count).by(1)
    end
    
    it 'is allowed to update a song' do
      song1 = create("song", new_work_title: 'new work title 1')
      expect(Song.count).to eq(1)
      create("song", new_work_title: 'new work title 2')
      expect(Song.count).to eq(2)
      put :update, params: {id: song1.id, song: {new_work_title: "changed title"}}
      expect(Song.find(song1.id).new_work_title).to eql("changed title")    
    end

    it 'is allowed to delete a song' do
      song1 = create("song", new_work_title: 'new work title 1')
      expect(Song.count).to eq(1)
      create("song", new_work_title: 'new work title 2')
      expect(Song.count).to eq(2)
      expect {delete :destroy, params: { id: song1.id }}
        .to change(Song, :count).by(-1)
    end

  end

end
