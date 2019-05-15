require 'rails_helper'

RSpec.describe 'Home features' do
  it 'displays the name of the app' do
    visit('/home')
    expect(page).to have_content('Cantando Ingles')
  end
end

