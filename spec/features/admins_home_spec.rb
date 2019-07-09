require 'rails_helper'

RSpec.describe 'Admin Home Leads to Songs feature' do
  it 'forwards to /admins/sign_in when click on See All Songs and no admin is signed in' do
    visit('/admin/home')
    click_link('See All Songs')
    expect(current_path).to eql('/admins/sign_in')
  end
  describe 'signing up as flocela and then ' do
    it 'displays admin/songs when click on See All Songs' do
      visit('/admins/sign_up')
      fill_in('Email', with: 'flocela@gmail.com')
      fill_in('Password', with: 'very-secret')
      fill_in('Password confirmation', with: 'very-secret')
      click_button('Sign up')
      expect(current_path).to eql('/')
      visit('/admin/home')
      click_link('See All Songs')
      expect(current_path).to eql('/admin/songs')
    end
    it 'creates a new song' do
      visit('/admins/sign_up')
      fill_in('Email', with: 'flocela@gmail.com')
      fill_in('Password', with: 'very-secret')
      fill_in('Password confirmation', with: 'very-secret')
      click_button('Sign up')
      expect(current_path).to eql('/')
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
    it 'creates a deletes a song it just created' do
      visit('/admins/sign_up')
      fill_in('Email', with: 'flocela@gmail.com')
      fill_in('Password', with: 'very-secret')
      fill_in('Password confirmation', with: 'very-secret')
      click_button('Sign up')
      expect(current_path).to eql('/')
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
     
