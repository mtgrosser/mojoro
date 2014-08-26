module Mojoro
  class << self
    def enable!
      Rails.application.middleware.use Mojoro::Middleware
    
      ActiveSupport::Notifications.subscribe('process_action.action_controller') do |name, started, finished, unique_id, data|
        Mojoro::Metrics.collect_action_controller(data, (finished - started) * 1000)
      end

      ActiveSupport::Notifications.subscribe('sql.active_record') do |name, started, finished, unique_id, data|
        Mojoro::Metrics.collect_active_record(data, (finished - started) * 1000)
      end
    end
  end
end