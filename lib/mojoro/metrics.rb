module Mojoro
  module Metrics
    class << self

      def collect_action_controller(data, runtime)
        action.name = "#{data[:controller]}##{data[:action]}"
        action.db = data[:db_runtime] || 0
        action.view = data[:view_runtime] || 0
        action.total = runtime
        action.path = data[:path]
        action.params = data[:params]
      end
      
      def collect_active_record(data, runtime)
        return if 'CACHE' == data[:type]
        action.sql << [data[:type] || 'Other SQL', runtime, ''] #data[:sql]]
      end

      def report
        reset!
        result = yield
        publish!
        result
      end

      protected

      def action
        Thread.current[:mojoro] ||= Action.new
      end
      
      def redis
        Mojoro.redis ||= Redis.new
      end
      
      def reset!
        Thread.current[:mojoro] = nil
      end
      
      def publish!
        return if !Thread.current[:mojoro] || action.blank?
        redis.publish Mojoro.channel, action.to_json
      rescue Redis::BaseError
        #
      end
      
    end
  end
end