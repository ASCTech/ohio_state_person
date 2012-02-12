require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'active_record'
require 'active_support'
require 'ohio_state_person'
require 'shoulda-matchers'
require 'factory_girl'

ActiveRecord::Base.logger = ActiveSupport::BufferedLogger.new(File.dirname(__FILE__) + "/debug.log")

config = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
ActiveRecord::Base.establish_connection(config['test'])

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.color_enabled = true
end
