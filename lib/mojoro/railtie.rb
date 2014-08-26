module Mojoro
  class Railtie < Rails::Railtie
    initializer 'mojoro.use_middleware' do |app|
      app.middleware.use Mojoro::Middleware
    end
  end
end