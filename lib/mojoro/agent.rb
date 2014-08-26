module Mojoro
  class Agent
    class << self
      
      def redis
        Mojoro.redis ||= Redis.new
      end
      
      def run        
      	begin
      	  redis.subscribe(Mojoro.channel) do |on|
      	    on.subscribe do |channel, subscriptions|
      	      puts "Subscribed to ##{channel} (#{subscriptions} subscriptions)"
      	    end

      	    on.message do |channel, message|
      	      puts "##{channel}: #{message}"
      	      redis.unsubscribe if message == "exit"
      	    end

      	    on.unsubscribe do |channel, subscriptions|
      	      puts "Unsubscribed from ##{channel} (#{subscriptions} subscriptions)"
      	    end
      	  end
      	rescue Redis::BaseConnectionError => error
      	  puts "#{error}, retrying in 1s"
      	  sleep 1
      	  retry
      	end
      end

    end
  end
end