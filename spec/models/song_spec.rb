require 'rails_helper'

describe Song do
  subject{described_class.new( new_work_title:                     'New Work Title',
                               song_type:                         '1',
                               orig_english_title:                'Original Title In English',
                               orig_artist:                       'Original Artist',
                               orig_downloaded_at_name:           'Name for Downloaded Originally',
                               orig_downloaded_at_link:           'Link for Downloaded Originally',
                               orig_pub_date:                     'Original Publication Date',
                               orig_lyrics_date:                  'Original Lyrics Date',
                               orig_lyrics_date_link_name:        'Name of Link for Original Lyrics Date',
                               orig_lyrics_date_link:             'Link for Original Lyrics Date',
                               orig_license_name:                 'Original License Name',
                               orig_license_link:                 'Original License Link',
                               orig_attribution_link:             'Original Attribution Link',
                               orig_uses_sample_from_link_name_1: 'Orig Uses Sample From Link Name 1',
                               orig_uses_sample_from_link_1:      'Orig Uses Sample From Link 1',
                               orig_english_uses_sample_from_1:   'Orig English Uses Sample From 1',
                               orig_spanish_uses_sample_from_1:   'Orig Spanish Uses Sample From 1',
                               name_of_new_work_license:          'Name of New Work License',
                               link_to_new_work_license:          'Link to New Work License',
                               orig_english_changes_made:         'Changes Made To Original In English',
                               orig_spanish_changes_made:         'Changes Made to Original In Spanish',                     
                               filename:                          'Filename',
                               zip_size:                          'Zip File Size')}
  describe 'validations' do
    describe 'new_work_title' do
      it 'must be present' do
        expect(subject).to be_valid
        subject.new_work_title = nil
        expect(subject).to_not be_valid
      end
    end 
    describe 'song_type' do
      it 'must be present' do
        expect(subject).to be_valid    
        subject.song_type = nil
        expect(subject).to_not be_valid
      end
    end 	
    describe 'orig_english_title' do
      it 'must be present' do
        expect(subject).to be_valid    
        subject.orig_english_title = nil
        expect(subject).to_not be_valid
      end
    end 
    describe 'orig_artist' do
      it 'must be present' do
        expect(subject).to be_valid    
        subject.orig_artist = nil
        expect(subject).to_not be_valid
      end
    end
    describe 'orig_downloaded_at_name' do
      it 'must be present' do
        expect(subject).to be_valid    
        subject.orig_downloaded_at_name = nil
        expect(subject).to_not be_valid
      end
    end
    describe 'orig_downloaded_at_link' do
      it 'must be present' do
        expect(subject).to be_valid    
        subject.orig_downloaded_at_link = nil
        expect(subject).to_not be_valid
      end
    end
    describe 'orig_license_name' do
      it 'must be present' do
        expect(subject).to be_valid    
        subject.orig_license_name = nil
        expect(subject).to_not be_valid
      end
    end
    describe 'orig_license_link' do
      it 'must be present' do
        expect(subject).to be_valid    
        subject.orig_license_link = nil
        expect(subject).to_not be_valid
      end
    end
    describe 'name_of_new_work_license' do
      it 'must be present' do
        expect(subject).to be_valid    
        subject.name_of_new_work_license = nil
        expect(subject).to_not be_valid
      end
    end
    describe 'link_to_new_work_license' do
      it 'must be present' do
        expect(subject).to be_valid    
        subject.link_to_new_work_license = nil
        expect(subject).to_not be_valid
      end
    end
    describe 'orig_english_changes_made' do
      it 'must be present' do
        expect(subject).to be_valid    
        subject.orig_english_changes_made = nil
        expect(subject).to_not be_valid
      end
    end
    describe 'orig_spanish_changes_made' do
      it 'must be present' do
        expect(subject).to be_valid    
        subject.orig_spanish_changes_made = nil
        expect(subject).to_not be_valid
      end
    end
    describe 'filename' do
      it 'must be present' do
        expect(subject).to be_valid    
        subject.filename = nil
        expect(subject).to_not be_valid
      end
    end
  end
end
