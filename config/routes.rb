Rails.application.routes.draw do
  get('home' => 'home#index')
  get('songs' => 'song#index')
  get('songs/new' => 'song#new')
  post('songs' => 'song#create')
end
