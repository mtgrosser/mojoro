module Mojoro
  
  class QueryTrace
    attr_reader :runtime, :sql, :count, :total_runtime
    
    def initialize(runtime, sql)
      @runtime = @total_runtime = runtime
      @sql = sql
      @count = 1
    end
    
    def update(new_runtime, sql)
      if new_runtime > runtime
        @sql = sql
        @runtime = new_runtime
      end
      @count += 1
      @total_runtime += new_runtime
    end
  end
  
  class QueryTracer
    
    def <<(ary)
      type, runtime, sql = ary
      if trace = traces[type]
        trace.update(runtime, sql)
      else
        traces[type] = QueryTrace.new(runtime, sql)
      end
    end
    
    def as_json(*)
      traces.map { |type, trace| [type, trace.total_runtime.round(PRECISION), trace.count, trace.runtime.round(PRECISION), trace.sql] }
    end
    
    private
    
    def traces
      @traces ||= {}
    end
  end
end