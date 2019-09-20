require 'rails_helper'

RSpec.describe 'Songs Featuer Spec' do 
  describe 'viewing the index' do
    it 'lists all existing songs' do
      create("song", new_work_title: 'new work title 1')
      create("song", new_work_title: 'new work title 2')
      visit('/songs')
      expect(page).to have_content('new work title 1')
      expect(page).to have_content('new work title 2')
    end

    it "does not show num of downloads when there are no downloads" do
      create("song", new_work_title: 'No Downloads Title')
      visit('/songs')
      expect(page).to have_content('No Downloads Title')
      expect(page).to_not have_content('Downloads this month') 
    end
    
    it 'shows number of downloads when there are downloads' do
      create("song", id: 10, new_work_title: 'Title 10')
      create("song", id: 20, new_work_title: 'Title 20')
      create("download_count", song_id: 10, 
                                       month: Date.current.beginning_of_month, 
                                       month_total: 10)
      create("download_count", song_id: 20, 
                                       month: Date.current.beginning_of_month, 
                                       month_total: 20)
      visit('/songs')
      expect(page).to have_content('Downloads this month: 10')
      expect(page).to have_content('Downloads this month: 20') 
    end
    
    it 'shows total number of downloads from all songs in this month' do
      create("download_count", 
             song_id: 10, 
             month: Date.current.beginning_of_month, 
             month_total: 10)
      create("download_count", 
             song_id: 20, 
             month: Date.current.beginning_of_month, 
             month_total: 20)
      visit('/songs')
      expect(page).to have_content('Total Downloads This Month: 30')
    end
  end

=begin
  describe 'downloading zip file' do
    it 'downloads zip file from amazon' do
      begin
       filepath = "#{Rails.root}/app/assets/songs/amazing_grace_rich_tuttle.zip" 
        expect(File.file?(filepath)).to be false
        create("song", id: 15, filename: 'amazing_grace_rich_tuttle')
        expect_any_instance_of(SongsController).to receive(:send_file)
          .with(filepath, 
                :filename => "amazing_grace_rich_tuttle.zip", 
                :url_based_filename => false, 
                :type => "application/zip")
          .and_call_original
        visit('/songs/get_zip/15')
      ensure
        File.delete(filepath) if File.exists?(filepath)
      end
    end
  end

  it 'a new song is created and deleted' do
    Capybara.current_driver = :selenium
    filepath = "#{Rails.root}/app/assets/songs/amazing_grace_rich_tuttle.zip" 
    expect(File.file?(filepath)).to be false
    
    visit('/admins/sign_up')
    fill_in('Email', with: 'flocela@gmail.com')
    fill_in('Password', with: 'very-secret')
    fill_in('Password confirmation', with: 'very-secret')
    click_button('Sign up')
    expect(current_path).to eql('/')
    
    visit('/admin/songs/new')
    fill_in('New Work Title', with: 'Amazing Grace Title')
    fill_in('Song Type', with: '3')
    fill_in('Original Title in E', with: 'Orig Eng Title')
    fill_in('Original Artist', with: 'Orig Artist')
    fill_in('Originally Downloaded At (name)', with: 'Orig Downloaded At Name')
    fill_in('Originally Downloaded At (link)', with: 'Orig Downloaded At Link')
    fill_in('Original License (name)', with: 'Orig License Name')
    fill_in('Original License (link)', with: 'Orig License Link')
    fill_in('New License (name)', with: 'Name of New Work License') 
    fill_in('New License (link)', with: 'Link to New Work License')
    fill_in('Filename', with: 'amazing_grace_rich_tuttle')
    fill_in('File Size', with: '5')
    fill_in('Changes Made To Orig (english)', with: 'changes english')
    fill_in('Changes Made To Orig (spanish)', with: 'changes spanish')
    click_button('Create')
    expect(current_path).to have_content('/admin/songs')
    
    visit('/songs')
    expect(page).to have_content('Amazing Grace Title')
    click_link('Download')
    a = page.driver.browser.switch_to.alert
    expect(a.text).to eq("Save As")
    expect(a.text).to eq("amazing_grace_rich_tuttle")
    
    File.delete(filepath) if File.exists?(filepath)
    Capybara.use_default_driver
  end
=end
  
end
