FactoryBot.define do
  factory :download_count do
    song_id { 1 }
    month { "2019-09-01" }
    month_total {0}
  end

  factory :admin do
    email {"flocela@gmail.com"}
    password {"12341234"}
    password_confirmation {"12341234"} 
  end

  factory :song do
    new_work_title {"new work title"}
    song_type {"1"}
    orig_english_title {"orig english title"}
    orig_artist {"orig_artist"}
    orig_downloaded_at_name {"orig downloaded at name"}
    orig_downloaded_at_link {"orig downloaded at link"}
    orig_license_name {"orig license name"}
    orig_license_link {"orig license link"}
    name_of_new_work_license {"name of new work license"}
    link_to_new_work_license {"link of new work license"}
    orig_english_changes_made {"changes made in english"}
    orig_spanish_changes_made {"changes made in spanish"}
    filename {"filename"}
    zip_size {5}
  end
end
