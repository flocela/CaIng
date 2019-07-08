Rails.application.routes.draw do
  devise_for :admins, controllers: {sessions: 'admins/sessions', registrations: 'admins/registrations'}
  namespace :admin do
    resources :songs
  end
  get('admin/home' => 'admin/home#index')
  root to: 'home#index'
  get('home' => 'home#index')
  get('songs' => 'songs#index')
end
