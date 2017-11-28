Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/blocks', to: 'blocks#index'
  post '/blocks', to: 'blocks#create'
  put '/blocks', to: 'blocks#update_all'
  post '/block/transactions', to: 'block/transactions#create'

  post '/nodes', to: 'nodes#create'
end
