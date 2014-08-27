module Mojoro
  class Trace < Action
    
    def initialize(data)
      data.each { |k, v| instance_variable_set "@#{k}", v }
    end

    def body(site_id)
      defaults = { idsite: site_id, rec: 1, apiv: 1, _id: id, url: "https://example.com#{path}" }
      req = []
      req << encode(defaults.merge(action_name: "#{name}/Total", gt_ms: total))
      req << encode(defaults.merge(action_name: "#{name}/Views", gt_ms: view))
      req << encode(defaults.merge(action_name: "#{name}/Database", gt_ms: db))
      
      sql.each do |db_name, db_total, db_count, db_runtime, db_sql|
        req << encode(defaults.merge(action_name: "#{name}/SQL/#{db_name}", gt_ms: db_total))
      end
      { requests: req }.to_json
    end
    
    private
    
    def encode(params)
      params.inject('?') { |str, key_value| str.concat("#{URI.escape(key_value[0].to_s)}=#{URI.escape(key_value[1].to_s)}&") }
    end
      
  end
end