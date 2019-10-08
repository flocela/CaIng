require 'rails_helper'

describe 'Inicio Feature Spec' do
  it 'displays the name of the app' do
    visit('/home')
    within 'h1' do
      have_content('Cantando Inglés')
    end
  end

  it 'displays link to canciones page' do
    visit('/home')
    within '.top-menu' do
      click_link('Canciones')
    end
    expect(current_path).to eql('/es/songs')
    expect(page).to have_content('Canciones')
  end
  
  it 'click on English goes to English page' do
    visit('/home')
    within '.menu-flex-container-sm .link-espanol' do
      click_link('English')
    end
    expect(current_path).to eq '/en/home'
    expect(page).to have_content('This phone application') 
  end
end

