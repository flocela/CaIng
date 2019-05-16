require 'rails_helper'

RSpec.describe 'Home features' do
  it 'displays the name of the app' do
    visit('/home')
    expect(page).to have_content('Cantando Ingles')
  end
  it 'displays link to songs page' do
    visit('/home')
    click_link('See All Songs')
    expect(current_path).to eql('/songs')
    expect(page).to have_content('Songs')
  end
end

