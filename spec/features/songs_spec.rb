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
  describe 'adding a new song' do
    it 'adds the song to the list of songs' do
      visit('/songs/new')
      fill_in('New Work Title', with: 'New Work Title 3')
      fill_in('Song Type', with: '3')
      fill_in('Original Title in E', with: 'Orig Eng Title 3')
      fill_in('Original Artist', with: 'Orig Artist 3')
      fill_in('Originally Downloaded At Name', with: 'Orig Downloaded At Name 3')
      fill_in('Originally Downloaded At Link', with: 'Orig Downloaded At Link 3')
      fill_in('Original License Name', with: 'Orig License Name 3')
      fill_in('Original License Link', with: 'Orig License Link 3')
      fill_in('New License Name', with: 'Name of New Work License 3') 
      fill_in('New License Link', with: 'Link to New Work License 3')
      fill_in('Filename', with: 'Filename 3')
      click_button('Create')
     
      expect(current_path).to have_content('/songs')
      expect(page).to have_content('New Work Title 3')
    end
  end
  describe 'deleting a song' do
    it 'deletes a song' do
      create("song", new_work_title: 'new work title 1')
      create("song", new_work_title: 'new work title 2')
      visit('songs')
      expect(page).to have_content('Delete')
      click_link('Delete', match: :first)
    end
  end
end
