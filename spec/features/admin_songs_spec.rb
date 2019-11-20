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
    
    describe 'fills in song form' do
      before(:each) do
	visit('/admin/songs/new')
	fill_in('New Work Title:', with: 'New Work Title 3')
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
	expect(page).to have_content('Cantando')
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
