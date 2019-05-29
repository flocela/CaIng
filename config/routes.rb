Rails.application.routes.draw do
  devise_for :admins
  namespace :admin do
    resources :songs
  end
  root to: 'home#index'
  get('home' => 'home#index')
  #get('songs' => 'songs#index')
  #post 'songs', to: 'songs#create'
  #get 'songs/new', to: 'songs#new', as: 'new_song'
  #get('songs/:id' => 'songs#show')
  #delete('songs/:id' => 'songs#destroy')
end
