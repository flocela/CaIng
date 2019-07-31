require 'rails_helper'

RSpec.describe 'Songs features' do 
  describe 'viewing the index' do
    it 'lists all of the songs' do
      create("song", new_work_title: 'new work title 1')
      create("song", new_work_title: 'new work title 2')
      visit('/songs')
      expect(page).to have_content('new work title 1')
      expect(page).to have_content('new work title 2')
    end
    it 'downloads zip file from amazon' do
      create("song", new_work_title: 'amazing_grace_download', id: 15, filename: 'amazing_grace_rich_tuttle.zip')
      expect_any_instance_of(SongsController).to receive(:send_file).with("app/assets/songs/amazing_grace_rich_tuttle.zip", :filename => "amazing_grace_rich_tuttle.zip", :url_based_filename => false, :type => "application/zip").and_call_original
      visit('/songs/get_zip/15')
    end
  end
end
