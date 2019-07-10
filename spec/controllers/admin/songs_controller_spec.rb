require 'rails_helper'

RSpec.describe Admin::SongsController do 
# SongsController defines the controller. This test must be inside /controllers or /requests directories. Maybe, file also must be named songs_controller.
  it 'allows flocela admin to open admin/songs/index' do
    admin = Admin.create!(email: "flocela@gmail.com", password: "very-secret", password_confirmation: "very-secret")
    sign_in admin
    get :index
    expect(response).to render_template("index")
  end
  
  it 'does not allow admin other than flocela to open admin/songs/index' do
    admin = Admin.create!(email: "abc@gmail.com", password: "very-secret", password_confirmation: "very-secret")
    sign_in admin
    get :index
    expect(response).to redirect_to(admin_session_path)
  end
 
  it 'flocela admin deletes a song from the list of songs' do
    admin = Admin.create!(email: "flocela@gmail.com", password: "very-secret", password_confirmation: "very-secret")
    sign_in admin
    song1 = create("song", new_work_title: 'new work title 1')
    expect(Song.count).to eq(1)
    create("song", new_work_title: 'new work title 2')
    expect(Song.count).to eq(2)
    expect { delete :destroy, params: { id: song1.id } }.to change(Song, :count).by(-1)
  end

  it 'does not allow song deletion when admin is signed out' do
    admin = Admin.create!(email: "flocela@gmail.com", password: "very-secret", password_confirmation: "very-secret")
    sign_in admin
    song1 = create("song", new_work_title: 'new work title 1')
    expect(Song.count).to eq(1)
    create("song", new_work_title: 'new work title 2')
    expect(Song.count).to eq(2)
    sign_out admin
    expect { delete :destroy, params: { id: song1.id } }.to change(Song, :count).by(0)
  end
  
  it 'does not allow song deletion when admin is other than flocela' do
    admin = Admin.create!(email: "flocela@gmail.com", password: "very-secret", password_confirmation: "very-secret")
    sign_in admin
    song1 = create("song", new_work_title: 'new work title 1')
    expect(Song.count).to eq(1)
    create("song", new_work_title: 'new work title 2')
    expect(Song.count).to eq(2)
    sign_out admin
    not_flo_admin = Admin.create!(email: "abc@gmail.com", password: "secret", password_confirmation: "secret")
    sign_in not_flo_admin #note: sign_in signs up abc@gmail.com although only flocela is allowed to register.
    expect { delete :destroy, params: { id: song1.id } }.to change(Song, :count).by(0)
  end

  it 'flocela admin creates a song' do
    song_attributes = attributes_for(:song)
    song_attributes[:new_work_title].should eq('new work title')
    admin = Admin.create!(email: "flocela@gmail.com", password: "very-secret", password_confirmation: "very-secret")
    sign_in admin
    expect { post(:create, params: { song: song_attributes}) }.to change(Song, :count).by(1)
  end

  it 'does not create a song when admin is not signed in' do
    song_attributes = attributes_for(:song)
    song_attributes[:new_work_title].should eq('new work title')
    expect { post(:create, params: { song: song_attributes}) }.to change(Song, :count).by(0)
  end

  it 'does not create a song when admin signed in is other than flocela ' do
    song_attributes = attributes_for(:song)
    song_attributes[:new_work_title].should eq('new work title')
    admin = Admin.create!(email: "other@gmail.com", password: "very-secret", password_confirmation: "very-secret")
    sign_in admin
    expect { post(:create, params: { song: song_attributes}) }.to change(Song, :count).by(0)
  end
end
