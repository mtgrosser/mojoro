$:.push File.expand_path('../lib', __FILE__)

require 'mojoro/version'

Gem::Specification.new do |s|
  s.name = 'mojoro'
  s.version = Mojoro::VERSION

  s.authors = ['Matthias Grosser']
  s.date = '2014-08-26'
  s.description = 'Rails application performance monitoring'
  s.email = 'mtgrosser@gmx.net'
  s.homepage = 'http://github.com/mtgrosser/mojoro'
  s.files = Dir['{lib}/**/*.rb', 'bin/mojoro', 'LICENSE', 'README.md', 'CHANGELOG']
  s.require_paths = ['lib']
  s.summary = 'Rails app performance monitoring'
  s.license = 'MIT'
  
  s.add_runtime_dependency 'eventmachine'
  s.add_runtime_dependency 'em-http-request'
  s.add_runtime_dependency 'em-hiredis'
  s.add_runtime_dependency 'redis', '~> 3.1', '>= 3.1.0'
  s.add_runtime_dependency 'railties', '~> 4.1', '>= 4.1.0'
  s.add_runtime_dependency 'dante', '~> 0'

  s.add_development_dependency 'byebug', '~> 0'
  s.add_development_dependency 'simplecov', '~> 0'
  s.add_development_dependency 'rake', '~> 0.8', '>= 0.8.7'
  s.add_development_dependency 'minitest', '~> 5.1'
end
