require 'rails_helper'
RSpec.describe 'Admin Songs Page' do
  describe 'admin is not signed in' do
    it 'then can not see admin/songs' do
      expect(Admin.count).to equal(0)
      visit('/admin/songs')
      expect(page).to have_content('You need to sign in or sign up')
    end
  end
  
  describe 'admin is signed in as flocela' do
    before(:each) do
      visit('/admins/sign_up')
      fill_in('Email', with: 'flocela@gmail.com')
      fill_in('Password', with: 'very-secret')
      fill_in('Password confirmation', with: 'very-secret')
      click_button('Sign up')
      expect(current_path).to eql('/')
    end
    
    it 'New Song link is shown' do
      visit('/admin/songs')
      within '.bot-menu' do
        click_link('New Song')
      end
      expect(current_path).to have_content('/admin/songs/new')  
    end 

    describe 'fills in song form' do
      before(:each) do
	visit('/admin/songs/new')
	fill_in('New Work Title', with: 'New Work Title 3')
	fill_in('Song Type', with: '3')
	fill_in('Original Title in E', with: 'Orig Eng Title 3')
	fill_in('Original Artist', with: 'Orig Artist 3')
	fill_in('Originally Downloaded At (name)', with: 'Orig Downloaded At Name 3')
	fill_in('Originally Downloaded At (link)', with: 'Orig Downloaded At Link 3')
	fill_in('Original License (name)', with: 'Orig License Name 3')
	fill_in('Original License (link)', with: 'Orig License Link 3')
	fill_in('New License (name)', with: 'Name of New Work License 3') 
	fill_in('New License (link)', with: 'Link to New Work License 3')
	fill_in('Changes Made To Orig (english)', with: 'Changes Made To Orig english 3')
	fill_in('Changes Made To Orig (spanish)', with: 'Changes Made To Orig spanish 3')
	fill_in('Filename', with: 'Filename 3')
	fill_in('File Size', with: '5')
      end 
      it 'a new song is created' do
	click_button('Create')
	expect(current_path).to have_content('/admin/songs')
	expect(page).to have_content('New Work Title 3')
      end

      it 'a new song is created and edited' do
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
    end 
 
  end

  describe 'using the selenium driver, admin is signed in as flocela' do
    before(:each) do
      Capybara.current_driver = :selenium
      visit('/admins/sign_up')
      fill_in('Email', with: 'flocela@gmail.com')
      fill_in('Password', with: 'very-secret')
      fill_in('Password confirmation', with: 'very-secret')
      click_button('Sign up')
      expect(current_path).to eql('/')
    end
    
    it 'a new song is created and deleted' do
      visit('/admin/songs/new')
      fill_in('New Work Title', with: 'New Work Title 3')
      fill_in('Song Type', with: '3')
      fill_in('Original Title in E', with: 'Orig Eng Title 3')
      fill_in('Original Artist', with: 'Orig Artist 3')
      fill_in('Originally Downloaded At (name)', with: 'Orig Downloaded At Name 3')
      fill_in('Originally Downloaded At (link)', with: 'Orig Downloaded At Link 3')
      fill_in('Original License (name)', with: 'Orig License Name 3')
      fill_in('Original License (link)', with: 'Orig License Link 3')
      fill_in('New License (name)', with: 'Name of New Work License 3') 
      fill_in('New License (link)', with: 'Link to New Work License 3')
      fill_in('Filename', with: 'Filename 3')
      fill_in('File Size', with: '5')
      fill_in('Changes Made To Orig (english)', with: 'changes english')
      fill_in('Changes Made To Orig (spanish)', with: 'changes spanish')
      click_button('Create')
      expect(current_path).to have_content('/admin/songs')
      expect(page).to have_content('New Work Title 3')
      click_link('Delete')
      a = page.driver.browser.switch_to.alert
      expect(a.text).to eq("Are you sure?")
      a.accept
      expect(page).to have_no_content('New Work Title 3', wait:5)
      Capybara.use_default_driver
    end
  end
end
     
