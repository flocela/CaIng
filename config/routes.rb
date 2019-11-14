Rails.application.routes.draw do
  devise_for :admins, controllers: {sessions: 'admins/sessions', registrations: 'admins/registrations'}
  resources :posts
  namespace :admin do
    resources :songs
  end
  root to: 'home#index'
  scope "(:locale)", locale: /en|es/ do
    get('home' => 'home#index')
    get('songs' => 'songs#index')
  end
  get 'welcome/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
