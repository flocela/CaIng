require 'rails_helper'

describe SongsController do

  describe 'when calling get_zip action ' do
 
      it 'Song.find is called if :id is an integer' do
        create("song", id:19, filename: 'act_cool_loveshadow')
        expect(Song).to receive(:find_by_id).and_call_original
        get :get_zip, params: {id:19}       
      end 


  end

end
