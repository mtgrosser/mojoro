module Mojoro
  class Action
    
    def initialize(store = nil)
      @store = store || { id: Kernel.rand(0xffffffffffffffff).to_s(0x10).rjust(16, '0')[0..15], sql: [] }
    end
    
    def blank?
      name.blank?
    end
    
    [:name, :db, :view, :total, :path, :params].each do |attr|
      define_method(attr) { store[attr] }
      define_method("#{attr}=") { |value| store[attr] = value }
    end
    
    [:id, :sql].each do |attr|
      define_method(attr) { store[attr] }
    end
    
    def as_json(*)
      store
    end
    
    def body(site_id)
      { requests: ["?idsite=#{site_id}&url=http://example.org&action_name=Test%20bulk%20log%20Pageview&rec=1"] }.to_json
    end
    
    private
    
    def store
      @store
    end
  end
end