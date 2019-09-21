Rails.application.routes.draw do
  devise_for :admins, controllers: {sessions: 'admins/sessions', registrations: 'admins/registrations'}
  namespace :admin do
    resources :songs
  end
  get('admin/home' => 'admin/home#index')
  root to: 'home#index'
  scope "(:locale)", locale: /en|es/ do
    get('home' => 'home#index')
    get('songs' => 'songs#index')
  end
  get "songs/get_zip/:id" => "songs#get_zip", :as => "songs_get_zip"
end
