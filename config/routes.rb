require 'sidekiq/web'

Rails.application.routes.draw do
  root 'main#index'

  post '/index' => 'main#create'
  mount Sidekiq::Web => '/sidekiq'
end
