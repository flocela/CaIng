Rails.application.routes.draw do
  get('home' => 'home#index')
  get('songs' => 'song#index')
end
