Rails.application.routes.draw do
  get('home' => 'home#index')
  get('songs' => 'song#index')
  post('songs' => 'song#create')
  get('songs/new' => 'song#new')
  get('song/:id' => 'song#show')
  delete('songs/:id' => 'song#destroy')
end
