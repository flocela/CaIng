require 'rails_helper'

describe 'features/home_spec: ' do

  describe 'in English home page' do

    it 'displays the name of the app' do
      visit('/en/home')
      within 'h1' do
        expect(page).to have_content('Cantando Inglés')
      end
    end
    
    it 'on-phone-size: click on Songs, goes to en/songs' do
      visit('/en/home')
      within '.menu-flex-container-xs' do
	click_link('Songs')
      end
      expect(current_path).to eql('/en/songs')
    end
    
    it 'on-med-size: click on Songs, goes to en/songs' do
      visit('/en/home')
      within '.menu-flex-container-sm' do
	click_link('Songs')
      end
      expect(current_path).to eql('/en/songs')
    end

    it 'on phone-size: click on Espańol goes to Spanish page' do
      visit('en/home')
      within '.menu-flex-container-xs' do
	click_link('Español')
      end
      expect(current_path).to eq '/es/home'
    end
    
    it 'on med-size: click on Spanish goes to Spanish page' do
      visit('/en/home')
      within '.menu-flex-container-sm' do
	click_link('Español')
      end
      expect(current_path).to eq '/es/home'
    end
  
  end

end


