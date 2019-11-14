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

  end

end
