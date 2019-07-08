require 'rails_helper'

RSpec.describe 'Admin Home feature' do
  it 'links to /admins/sign_in when admin is not signed in and clicks See All Songs' do
    visit('/admin/home')
    click_link('See All Songs')
    expect(current_path).to eql('/admins/sign_in')
  end
end
     
