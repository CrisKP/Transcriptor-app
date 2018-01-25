Rails.application.routes.draw do
  root 'main#index'

  post '/index' => 'main#create'

end
