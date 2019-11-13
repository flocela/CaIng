require 'rails_helper'

describe 'Inicio Feature Spec' do
  describe 'In Spanish home page' do
    it 'displays the name of the app' do
      visit('/home')
      within 'h1' do
	expect(page).to have_content('Cantando Inglés')
      end
    end

    it 'on phone-size, click on Canciones goes to es/songs' do
      visit('/home')
      within '.menu-flex-container-xs' do
	click_link('Canciones')
      end
      expect(current_path).to eql('/es/songs')
    end

    it 'on med-size, click on Canciones goes to es/songs' do
      visit('/home')
      within '.menu-flex-container-sm' do
	click_link('Canciones')
      end
      expect(current_path).to eql('/es/songs')
    end

    it 'on phone-size, click on English goes to English page' do
      visit('/home')
      within '.menu-flex-container-xs' do
	click_link('English')
      end
      expect(current_path).to eq '/en/home'
    end
    
    it 'on med-size, click on English goes to English page' do
      visit('/home')
      within '.menu-flex-container-sm' do
	click_link('English')
      end
      expect(current_path).to eq '/en/home'
    end
  end

  
end

