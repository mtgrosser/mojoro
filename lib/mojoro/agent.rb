require 'eventmachine'
require 'em-http-request'
require 'em-hiredis'
require 'byebug'

module Mojoro
  class Agent
    private_class_method :new
    
    attr_reader :url, :site_id, :channel, :redis
    
    class << self
      def run(url, site_id, options = {})
        new(url, site_id, options).run
      end
    end
    
    def initialize(url, site_id, options = {})
      @url = url #URI.parse(url)
      @site_id = site_id
      @options = options
    end
    
    def run
      EM.run do
        @channel = EM::Channel.new
        channel.subscribe { |message| submit!(message) }
        @redis = EM::Hiredis.connect
  	    redis.pubsub.subscribe(Mojoro.channel) { |message| channel.push message }
        puts "Subscribed to ##{Mojoro.channel}"        
      end
    end
        
    private
          
    def submit!(message)
      action = Action.new(ActiveSupport::JSON.decode(message))
      http = EventMachine::HttpRequest.new(url).post(body: action.body(site_id))
=begin      
      puts url
      puts action.body(site_id)
      puts http.inspect
      http.errback { puts 'Uh oh' }
      http.callback {
        p http.response_header.status
        p http.response_header
        p http.response
      }
=end
    rescue JSON::ParserError
      #
    end

  end
end