require 'rails_helper'

RSpec.describe 'Canciones Feature Spec' do
  it 'displays the name of the app' do
    visit('/es/home')
    expect(page).to have_content('Cantando Inglés')
  end

  it 'displays link to canciones page' do
    visit('/es/home')
    within '.top-menu' do
      click_link('Canciones')
    end
    expect(current_path).to eql('/es/songs')
    expect(page).to have_content('Canciones')
  end
end

