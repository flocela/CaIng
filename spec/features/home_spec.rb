require 'rails_helper'

RSpec.describe 'Home Feature Spec' do
  describe 'en home' do
    it 'displays the name of the app' do
      visit('/en/home')
      within 'h1' do
        have_content('Cantando Inglés')
      end
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
 
end

