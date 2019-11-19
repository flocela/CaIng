require 'rails_helper'
describe 'Admin Songs Feature Spec' do
  describe 'admin is signed in as flocela' do
    before(:each) do
      visit('/admins/sign_up')
      fill_in('Email', with: 'flocela@gmail.com')
      fill_in('Password', with: 'very-secret')
      fill_in('Password confirmation', with: 'very-secret')
      click_button('Sign up')
      expect(current_path).to eql('/')
    end
    
    it 'visits admin/songs and Admin Home link is shown' do
      visit('/admin/songs')
      within '.menu-flex-container-sm' do
        click_link('Admin Home')
      end
      expect(current_path).to have_content('/admin/home')  
    end 
    
    it 'visits admin/songs and New Song link is shown' do
      visit('/admin/songs')
      within '.menu-flex-container-sm' do
        click_link('New Song')
      end
      expect(current_path).to have_content('/admin/songs/new')  
    end 
    
    it 'visits admin/songs and New Song link is shown' do
      visit('/admin/songs')
      within '.menu-flex-container-sm' do
        click_link('New Song')
      end
      expect(current_path).to have_content('/admin/songs/new')  
    end 

    it 'visits admin/songs and Sign-Out link is shown' do
      visit('/admin/songs')
      within '.menu-flex-container-sm' do
        click_link('Sign-Out')
      end
      visit('/admin/songs')
      expect(current_path).to have_content('admins/sign_in')
    end 

  end
end
