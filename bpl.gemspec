# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version'

Gem::Specification.new do |gem|
  gem.name          = "bpl"
  gem.version       = Bpl::VERSION
  gem.authors       = ["Florin T.PATRASCU"]
  gem.email         = ["florin.patrascu@gmail.com"]
  gem.description   = %q{BPL is a gem to help you track your blood pressure and view your records over time}
  gem.summary       = %q{Blood pressure logger}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  # Gem dependencies for run-time
  gem.add_runtime_dependency "yajl-ruby"
  gem.add_runtime_dependency 'sqlite3'
  gem.add_runtime_dependency 'yajl-ruby'
  gem.add_runtime_dependency 'chronic'
  gem.add_runtime_dependency 'activerecord-sqlserver-adapter'
  gem.add_runtime_dependency 'activerecord'
  gem.add_runtime_dependency 'time_of_day'
  gem.add_runtime_dependency 'tablizer'
  
  # Gem dependencies for development
  gem.add_development_dependency "rspec"
  
end
