module Mojoro
  class Action
    
    def initialize
      @store = { id: Kernel.rand(0xffffffffffffffff).to_s(0x10).rjust(16, '0')[0..15], sql: [] }
    end
    
    def blank?
      name.blank?
    end
    
    [:name, :db, :view, :total, :path, :params].each do |attr|
      define_method(attr) { store[attr] }
      define_method("#{attr}=") { |value| store[attr] = value }
    end
    
    def sql
      store[:sql]
    end
    
    def as_json(*)
      store
    end
    
    private
    
    def store
      @store
    end
  end
end