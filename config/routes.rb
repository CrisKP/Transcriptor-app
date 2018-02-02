require 'sidekiq/web'

Rails.application.routes.draw do
  root 'main#index'

  post '/index' => 'main#create'

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    def hex(value)
      ::Digest::SHA256.hexdigest value
    end

    def compare(left, right)
      ActiveSupport::SecurityUtils.secure_compare(left, right)
    end

    compare(hex(username), hex(ENV["SIDEKIQ_USERNAME"])) &
      compare(hex(password), hex(ENV["SIDEKIQ_PASSWORD"]))
  end if Rails.env.production?

  mount Sidekiq::Web, at: '/sidekiq'
end
