module Mojoro
  class Trace < Action
    
    def initialize(data)
      data.each { |k, v| instance_variable_set "@#{k}", v }
    end

    def body(site_id)
      { requests: ["?idsite=#{site_id}&url=http://example.org&action_name=Test%20bulk%20log%20Pageview&rec=1"] }.to_json
    end
      
  end
end