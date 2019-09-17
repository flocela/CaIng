require 'rails_helper'
RSpec.describe 'Admin Home Feature Spec' do
 
  context "Admin is not signed in then" do
    it 'Sign Out link is not shown' do
      visit('/admin/home')
      expect(page).to_not have_link('Sign Out')
    end
    
    it 'Delete Registration link is not shown' do
      visit('/admin/home')
      expect(page).to_not have_link('Delete Registration')
    end
   
    it 'Admin-Songs link is not shown' do
      visit('/admin/home')
      expect(page).to_not have_link('Admin-Songs')
    end
    
   
    it 'Sign In link is shown' do
      expect(Admin.count).to equal(0)
      visit('/admin/home')
      expect(page).to have_content('Sign In')
    end 
    
    it 'Register link is shown' do
      expect(Admin.count).to equal(0)
      visit('/admin/home')
      expect(page).to have_content('Register')
    end 
  end 

  describe 'flocela signs in as admin and ' do
    before(:each) do
      visit('/admins/sign_up')
      fill_in('Email', with: 'flocela@gmail.com')
      fill_in('Password', with: 'very-secret')
      fill_in('Password confirmation', with: 'very-secret')
      click_button('Sign up')
    end

    it 'Admin-Songs link is shown' do
      visit('/admin/home')
      within '.admin-links-column' do
        expect(page).to have_link('Admin-Songs')
      end
    end

    it 'Sign-Out link is shown' do
      visit('/admin/home')
      expect(page).to have_link'Sign Out'
    end

    it 'goes to admin/songs when Admin-Songs is clicked' do 
      expect(current_path).to eql('/')
      visit('/admin/home')
      within '.admin-links-column' do
	click_link('Admin-Songs')
      end
      expect(current_path).to eql('/admin/songs')
    end
  end

end
