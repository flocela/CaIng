require 'rails_helper'

RSpec.describe 'features/home: ' do
  it 'displays the name of the app' do
    visit('/home')
    expect(page).to have_content('Cantando Inglés')
  end

  it 'displays link to songs page' do
    visit('/home')
    click_link('All Songs')
    expect(current_path).to eql('/songs')
    expect(page).to have_content('Songs')
  end
end

