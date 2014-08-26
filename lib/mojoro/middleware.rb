module Mojoro
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      Mojoro::Metrics.report { @app.call(env) }
    end
  end
end