require 'rails_helper'
RSpec.describe 'Features Admin Songs' do
  describe 'signing up as flocela and then ' do
    before(:each) do
      visit('/admins/sign_up')
      fill_in('Email', with: 'flocela@gmail.com')
      fill_in('Password', with: 'very-secret')
      fill_in('Password confirmation', with: 'very-secret')
      click_button('Sign up')
      expect(current_path).to eql('/')
      
    end
    
    it 'links to New Song Page' do
      visit('/admin/songs')
      click_link('New Song')
      expect(current_path).to have_content('/admin/songs/new')  
    end 
 
    it 'creates a new song' do
      visit('/admin/songs/new')
      fill_in('New Work Title', with: 'New Work Title 3')
      fill_in('Song Type', with: '3')
      fill_in('Original Title in E', with: 'Orig Eng Title 3')
      fill_in('Original Artist', with: 'Orig Artist 3')
      fill_in('Originally Downloaded At Name', with: 'Orig Downloaded At Name 3')
      fill_in('Originally Downloaded At Link', with: 'Orig Downloaded At Link 3')
      fill_in('Original License Name', with: 'Orig License Name 3')
      fill_in('Original License Link', with: 'Orig License Link 3')
      fill_in('New License Name', with: 'Name of New Work License 3') 
      fill_in('New License Link', with: 'Link to New Work License 3')
      fill_in('Filename', with: 'Filename 3')
      click_button('Create')
      expect(current_path).to have_content('/admin/songs')
      expect(page).to have_content('New Work Title 3')
    end

    it 'edits a song' do
      visit('/admin/songs/new')
      fill_in('New Work Title', with: 'New Work Title 3')
      fill_in('Song Type', with: '3')
      fill_in('Original Title in E', with: 'Orig Eng Title 3')
      fill_in('Original Artist', with: 'Orig Artist 3')
      fill_in('Originally Downloaded At Name', with: 'Orig Downloaded At Name 3')
      fill_in('Originally Downloaded At Link', with: 'Orig Downloaded At Link 3')
      fill_in('Original License Name', with: 'Orig License Name 3')
      fill_in('Original License Link', with: 'Orig License Link 3')
      fill_in('New License Name', with: 'Name of New Work License 3') 
      fill_in('New License Link', with: 'Link to New Work License 3')
      fill_in('Filename', with: 'Filename 3')
      click_button('Create')
      expect(current_path).to have_content('/admin/songs')
      expect(page).to have_content('New Work Title 3')
      click_link('Edit')
      expect(page).to have_content('Edit Song')
      expect(find_field('New Work Title').value).to eq 'New Work Title 3'
      fill_in('New Work Title', with: 'New Work Title 4')
      click_button('Edit')
      expect(current_path).to have_content('/admin/songs')
      expect(page).to have_content('New Work Title 4')
    end
  
    it 'deletes a song it just created' do
      visit('/admin/songs/new')
      fill_in('New Work Title', with: 'New Work Title 3')
      fill_in('Song Type', with: '3')
      fill_in('Original Title in E', with: 'Orig Eng Title 3')
      fill_in('Original Artist', with: 'Orig Artist 3')
      fill_in('Originally Downloaded At Name', with: 'Orig Downloaded At Name 3')
      fill_in('Originally Downloaded At Link', with: 'Orig Downloaded At Link 3')
      fill_in('Original License Name', with: 'Orig License Name 3')
      fill_in('Original License Link', with: 'Orig License Link 3')
      fill_in('New License Name', with: 'Name of New Work License 3') 
      fill_in('New License Link', with: 'Link to New Work License 3')
      fill_in('Filename', with: 'Filename 3')
      click_button('Create')
      expect(current_path).to have_content('/admin/songs')
      expect(page).to have_content('New Work Title 3')
      click_link('Delete')
      expect(page).to have_no_content('New Work Title 3')
    end
  end
end
     
