Rails.application.routes.draw do
  get '/', to: 'welcome#show'
  get '/auth/:provider/callback', to: 'sessions#create'
  resources :users, only: [:show]
end
