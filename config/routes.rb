Rails.application.routes.draw do
  resources :posts
  root 'home#index'
  scope "(:locale)", locale: /en|es/ do
    get('home' => 'home#index')
    get('songs' => 'songs#index')
  end
  get 'welcome/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
