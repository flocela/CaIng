require 'rails_helper'

RSpec.describe 'Home Feature Spec' do
  describe 'en home' do
    it 'displays the name of the app' do
      visit('/en/home')
      expect(page).to have_content('Cantando Inglés')
    end
    
    it 'displays link to songs page' do
      visit('/en/home')
      within '.top-menu' do
	click_link('Songs')
      end
      expect(current_path).to eql('/en/songs')
      expect(page).to have_content('Songs')
    end
  end
 
  describe 'es home' do
    it 'displays the name of the app' do
      visit('/home')
      expect(page).to have_content('Cantando Inglés')
    end

    it 'displays link to songs page' do
      visit('/home')
      within '.top-menu' do
	click_link('Canciones')
      end
      expect(current_path).to eql('/es/songs')
      expect(page).to have_content('Canciones')
    end
  end 
end

