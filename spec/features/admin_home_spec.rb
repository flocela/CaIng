require 'rails_helper'
RSpec.describe 'Admin Home Links To Songs' do
  
  it 'forwards to /admins/sign_in when click on See All Songs and no admin is signed in' do
    visit('/admin/home')
    click_link('See All Songs')
    expect(current_path).to eql('/admins/sign_in')
  end

  it 'displays admin/songs when click on See All Songs and flocela is signed in' do
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
  
  it 'will not register admin that is not flocela@gmail.com' do
    visit('/admins/sign_up')
    fill_in('Email', with: 'abc@gmail.com')
    fill_in('Password', with: 'very-secret')
    fill_in('Password confirmation', with: 'very-secret')
    click_button('Sign up')
    expect(Admin.count).to equal(0)
  end
  
  it 'if admin is not signed in then can not see admin/songs' do
    expect(Admin.count).to equal(0)
    visit('/admin/home')
    click_link('See All Songs')
    expect(page).to have_content('You need to sign in or sign up')
  end

end
