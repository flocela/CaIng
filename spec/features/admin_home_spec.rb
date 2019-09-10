require 'rails_helper'
RSpec.describe 'Admin Home' do
  
  it 'will not register admin that is not flocela@gmail.com' do
    visit('/admins/sign_up')
    fill_in('Email', with: 'abc@gmail.com')
    fill_in('Password', with: 'very-secret')
    fill_in('Password confirmation', with: 'very-secret')
    click_button('Sign up')
    expect(Admin.count).to equal(0)
  end
  
  it 'Sign Out is not shown when admin is not signed_in' do
    visit('/admin/home')
    expect(page).to_not have_link('Sign Out')
  end
  
  it 'Delete Registration is not shown when admin is not signed_in' do
    visit('/admin/home')
    expect(page).to_not have_link('Delete Registration')
  end
 
  it 'Admin-Songs is not shown when admin is not signed_in' do
    visit('/admin/home')
    expect(page).to_not have_link('Admin-Songs')
  end
  
 
  it 'if admin is not signed in then shows Sign In' do
    expect(Admin.count).to equal(0)
    visit('/admin/home')
    expect(page).to have_content('Sign In')
  end 
  
  it 'if admin is not signed in then shows Register' do
    expect(Admin.count).to equal(0)
    visit('/admin/home')
    expect(page).to have_content('Register')
  end 

  describe 'flocela signs in as admin and ' do
    before(:each) do
      visit('/admins/sign_up')
      fill_in('Email', with: 'flocela@gmail.com')
      fill_in('Password', with: 'very-secret')
      fill_in('Password confirmation', with: 'very-secret')
      click_button('Sign up')
    end

    it 'visits admin/home and shows Sign-Out link' do
      visit('/admin/home')
      within '.admin-links-column' do
        expect(page).to have_link('Admin-Songs')
      end
    end

    it 'shows Sign-Out link' do
      visit('/admin/home')
      expect(page).to have_link'Sign Out'
    end

    it 'shows Sign-Out link' do
      visit('/admin/home')
      expect(page).to have_link'Sign Out'
    end
    
    it 'displays admin/songs when click Admin-Songs and flocela is signed in' do
      expect(current_path).to eql('/')
      visit('/admin/home')
      within '.admin-links-column' do
	click_link('Admin-Songs')
      end
      expect(current_path).to eql('/admin/songs')
    end
  end

end
