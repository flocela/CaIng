require 'rails_helper'

RSpec.describe 'Songs features' do 
  describe 'viewing the index' do
    it 'lists all of the songs' do
      create("song", new_work_title: 'new work title 1')
      create("song", new_work_title: 'new work title 2')
      visit('/songs')
      expect(page).to have_content('new work title 1')
      expect(page).to have_content('new work title 2')
    end
  end
end
