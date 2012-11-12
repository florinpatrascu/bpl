ENV['ENV'] = 'test'
$LOAD_PATH.unshift( File.join( File.dirname(__FILE__), 'lib' ) )

require "bundler/setup"
require 'active_record'
require "create_blood"

DATE_FORMAT = '%Y-%m-%d'
TIME_FORMAT = '%H:%M:%S'
  
ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"
CreateBlood.up

Dir["./lib/**/*.rb"].each { |f| require f}
