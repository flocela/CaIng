require 'rails_helper'

RSpec.describe 'Songs requests' do
  before do
    create(:song, new_work_title: 'new work title 1');
    create(:song, new_work_title: 'new work title 2');
  end
  describe 'GET /songs' do
    it 'returns an array of songs' do
      get('/songs')
      response_json = JSON.parse(response.body)
      expect(response_json['songs']).to contain_exactly(
        'new work title 1',
        'new work title 2') 
    end
  end
end
