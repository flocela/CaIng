require 'rails_helper'

RSpec.describe 'Songs features' do 
  describe 'viewing the index' do
    it 'lists all existing songs' do
      create("song", new_work_title: 'new work title 1')
      create("song", new_work_title: 'new work title 2')
      visit('/songs')
      expect(page).to have_content('new work title 1')
      expect(page).to have_content('new work title 2')
    end

    it "does not show num of downloads when there are no downloads" do
      create("song", new_work_title: 'No Downloads Song')
      visit('/songs')
      expect(page).to have_content('No Downloads Song')
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
        expect(File.file?('app/assets/songs/amazing_grace_rich_tuttle.zip')).to be false
        create("song", id: 15, filename: 'amazing_grace_rich_tuttle')
        expect_any_instance_of(SongsController).to 
          receive(:send_file)
          .with("app/assets/songs/amazing_grace_rich_tuttle.zip", 
                :filename => "amazing_grace_rich_tuttle.zip", 
                :url_based_filename => false, 
                :type => "application/zip")
          .and_call_original
        visit('/songs/get_zip/15')
      ensure
        if (File.exists?('app/assets/songs/amazing_grace_rich_tuttle.zip')
          File.delete('app/assets/songs/amazing_grace_rich_tuttle.zip')
        end
      end
    end
  end
=end
end
