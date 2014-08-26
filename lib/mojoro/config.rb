module Mojoro
  PRECISION = 2
  
  # Redis connection (optional)
  mattr_accessor :redis
  
  # Optional redis namespace
  mattr_accessor :namespace
  
  # All transactions exceeding this limit will be traced (default: 100 ms)
  mattr_accessor :transaction_trace_threshold
  self.transaction_trace_threshold = 100
  
  class << self
    def channel
      return @channel if @channel
      @channel = [namespace, 'mojoro'].compact.join(':')
    end
  end
end