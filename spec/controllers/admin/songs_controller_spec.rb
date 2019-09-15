require 'rails_helper'

RSpec.describe Admin::SongsController do 
  describe 'flocela signs in as admin, and ' do
    before(:each) do
      admin = Admin.create!(email: "flocela@gmail.com", password: "very-secret", password_confirmation: "very-secret")
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
      song = create("song", new_work_title: 'new work title1')
      get :edit, params: {id: song.id}
      expect(response).to render_template("edit")
    end 
  
    it 'is allowed to create a song' do
      song_attributes = attributes_for(:song)
      expect { post(:create, params: { song: song_attributes}) }.to change(Song, :count).by(1)
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
      expect { delete :destroy, params: { id: song1.id } }.to change(Song, :count).by(-1)
    end

    it 'calls admin/songs/edit with an integer :id, the result is Song.find is called' do
      create("song", id:19, filename: 'act_cool_loveshadow')
      expect(Song).to receive(:find_by_id).and_call_original
      get :edit, params: {id:19}
    end
    
    it 'calls admin/songs/edit with a non-integer :id, the result is Song.find is not called' do
      create("song", id:19, filename: 'act_cool_loveshadow')
      expect(Song).to_not receive(:find_by_id).and_call_original
      get :edit, params: {"id":"19a"}
    end
    
    it 'calls admin/songs/edit with a non-integer :id, the result is a flash notice' do
      create("song", id:19, filename: 'act_cool_loveshadow')
      get :edit, params: {"id":"19a"}
      expect(flash[:notice]).to match('that is not an integer') 
    end  

  end
  
  describe 'Admin other than flocela signs in (although only flocela is allowed to register) and' do
    before(:each) do
      admin = Admin.create!(email: "abc@gmail.com", password: "very-secret", password_confirmation: "very-secret")
       sign_in admin
    end

    it 'is not allowed to open admin/songs/index' do
      get :index
      expect(response).to redirect_to(new_admin_session_path)
    end
    
   it 'is not allowed to open admin/songs/new' do
      get :new
      expect(response).to redirect_to(new_admin_session_path)
    end 
    
    it "is not allowed to open admin/songs/edit" do
      song = create("song", new_work_title: 'new work title1')
      get :edit, params: {id: 1}
      expect(response).to redirect_to(new_admin_session_path)
    end

    it 'is not allowed to create a song ' do
      song_attributes = attributes_for(:song)
      song_attributes[:new_work_title].should eq('new work title')
      expect { post(:create, params: { song: song_attributes}) }.to change(Song, :count).by(0)
    end
    
    it 'is not allowed to update a song' do
      song1 = create("song", new_work_title: 'new work title 1')
      expect(Song.count).to eq(1)
      create("song", new_work_title: 'new work title 2')
      expect(Song.count).to eq(2)
      put :update, params: {id: song1.id, song: {new_work_title: "changed title"}}
      expect(Song.find(song1.id).new_work_title).to eql("new work title 1")    
    end
  
    it 'is not allowed to delete a song' do
      song1 = create("song", new_work_title: 'new work title 1')
      expect(Song.count).to eq(1)
      create("song", new_work_title: 'new work title 2')
      expect(Song.count).to eq(2)
      expect { delete :destroy, params: { id: song1.id } }.to change(Song, :count).by(0)
    end

  end

  describe 'No admin signs in and' do
    
    it 'is not allowed to open opening admin/songs/index' do
      get :index
      expect(response).to redirect_to(new_admin_session_path)
    end
    
    it 'is not allowed to open admin/songs/new' do
      get :new
      expect(response).to redirect_to(new_admin_session_path)
    end 
    
    it "is not allowed to open admin/songs/edit" do
      song = create("song", new_work_title: 'new work title1')
      get :edit, params: {id: 1}
      expect(response).to redirect_to(new_admin_session_path)
    end

    it 'is not allowed to create a song' do
      song_attributes = attributes_for(:song)
      song_attributes[:new_work_title].should eq('new work title')
      expect { post(:create, params: { song: song_attributes}) }.to change(Song, :count).by(0)
    end
    
    it 'is not allowed to update a song' do
      song1 = create("song", new_work_title: 'new work title 1')
      expect(Song.count).to eq(1)
      create("song", new_work_title: 'new work title 2')
      expect(Song.count).to eq(2)
      put :update, params: {id: song1.id, song: {new_work_title: "changed title"}}
      expect(Song.find(song1.id).new_work_title).to eql("new work title 1")    
    end
  
    it 'is not allowed to delete a song' do
      song1 = create("song", new_work_title: 'new work title 1')
      expect(Song.count).to eq(1)
      create("song", new_work_title: 'new work title 2')
      expect(Song.count).to eq(2)
      expect { delete :destroy, params: { id: song1.id } }.to change(Song, :count).by(0)
    end

  end  

end
