module Mojoro
  class Action
    attr_reader :id, :sql
    attr_accessor :name, :db, :view, :total, :path, :params
    
    def initialize
      @id = Kernel.rand(0xffffffffffffffff).to_s(0x10).rjust(16, '0')[0..15]
      @db = @view = @total = 0
      @sql = QueryTracer.new
    end
    
    def blank?
      name.blank?
    end
    
    #[:name, :db, :view, :total, :path, :params].each do |attr|
    #  define_method(attr) { store[attr] }
    #  define_method("#{attr}=") { |value| store[attr] = value }
    #end
    #
    #[:id, :sql].each do |attr|
    #  define_method(attr) { store[attr] }
    #end
    
    def as_json(*)
      {
        id: id,
        name: name,
        db: db.round(PRECISION),
        view: view.round(PRECISION),
        total: total.round(PRECISION),
        path: path,
        params: params,
        sql: sql
      }
    end
    
    private
    
    #def store
    #  @store
    #end
  end
end