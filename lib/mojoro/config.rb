module Mojoro
  
  # Redis connection (optional)
  mattr_accessor :redis
  
  # Optional redis namespace
  mattr_accessor :namespace
  
  class << self
    def channel
      return @channel if @channel
      @channel = [namespace, 'mojoro'].compact.join(':')
    end
    
    def enable!
      ActiveSupport::Notifications.subscribe('process_action.action_controller') do |name, started, finished, unique_id, data|
        Mojoro::Metrics.collect_action_controller(data, (finished - started) * 1000)
      end

      ActiveSupport::Notifications.subscribe('sql.active_record') do |name, started, finished, unique_id, data|
        Mojoro::Metrics.collect_active_record(data, (finished - started) * 1000)
      end
    end
  end
end