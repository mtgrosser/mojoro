# mojoro

Rails application performance monitoring

## Install

```ruby
gem 'mojoro', '~> 0.2.0'
```

## In your application

```ruby
# config/initializers/mojoro.rb
require 'mojoro/metrics'
Mojoro.enable!
```   

### Configuration options

You can set the following options in your initializer:

```ruby
# Redis pub/sub channel will be prefixed with this namespace
Mojoro.namespace = 'some_optional_namespace'

# If you don't want to use the default Redis connection, you can initialize it here
Mojoro.redis = Redis.new(:url => 'redis://:p4ssw0rd@10.0.1.1:6380/15')
    
# If action duration exceeds this threshold in milliseconds, trace it
Mojoro.transaction_trace_threshold = 200
```

## Agent

The Morojo agent is responsible for relaying all collected performance data to your analytics app.

```bash
# Starting the agent
$ bundle exec mojoro -a http://analytics.example.com/piwik,php -s 3 --n some_optional_namespace -d -l log/mojoro.log -P tmp/pids/mojoro.pid

# Stopping it
$ bundle exec mojoro -k -P tmp/pids/mojoro.pid
```
