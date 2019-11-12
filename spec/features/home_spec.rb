require 'rails_helper'

describe 'Home Feature Spec' do
  describe 'en home' do
    it 'displays the name of the app' do
      visit('/en/home')
      within 'h1' do
        have_content('Cantando Inglés')
      end
    end
  end
 
end


