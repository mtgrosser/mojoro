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
  s.files = Dir['{lib}/**/*.rb', 'LICENSE', 'README.md', 'CHANGELOG']
  s.require_paths = ['lib']
  s.summary = ''
  s.license = 'MIT'
  
  s.add_dependency 'redis', '~> 3.1.0'
  s.add_dependency 'railties', '~> 4.1.0'
  s.add_dependency 'dante'

  s.add_development_dependency('byebug', ['>= 0'])
  s.add_development_dependency('simplecov', ['>= 0'])
  s.add_development_dependency('rake', ['>= 0.8.7'])
  s.add_development_dependency('minitest', ['~> 5.1'])
end