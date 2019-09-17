require 'rails_helper'
RSpec.describe 'Admin Registration Feature Spec' do
  
  it 'will not register admin that is not flocela@gmail.com' do
    visit('/admins/sign_up')
    fill_in('Email', with: 'abc@gmail.com')
    fill_in('Password', with: 'very-secret')
    fill_in('Password confirmation', with: 'very-secret')
    click_button('Sign up')
    expect(Admin.count).to equal(0)
  end

end
