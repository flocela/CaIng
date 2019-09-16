require 'rails_helper'

RSpec.describe 'Home Page: ' do
  it 'displays the name of the app' do
    visit('/home')
    expect(page).to have_content('Cantando Inglés')
  end

  it 'displays link to songs page' do
    visit('/home')
    within '.top-menu' do
      click_link('Songs')
    end
    expect(current_path).to eql('/songs')
    expect(page).to have_content('Songs')
  end
end

