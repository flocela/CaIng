require 'rails_helper'

describe 'Inicio Feature Spec' do
  it 'home page displays the name of the app' do
    visit('/home')
    within 'h1' do
      expect(page).to have_content('Cantando Inglés')
    end
  end

  it 'on phone-size, spanish, home page spanish click on Canciones goes to es/songs' do
    visit('/home')
    within '.menu-flex-container-xs' do
      click_link('Canciones')
    end
    expect(current_path).to eql('/es/songs')
  end

  it 'on med-size, spanish, home page click on Canciones goes to es/songs' do
    visit('/home')
    within '.menu-flex-container-sm' do
      click_link('Canciones')
    end
    expect(current_path).to eql('/es/songs')
  end

  it 'on home page, click on English goes to English page' do
    visit('/home')
    within '.menu-flex-container-sm .link-espanol' do
      click_link('English')
    end
    expect(current_path).to eq '/en/home'
  end

  
end

