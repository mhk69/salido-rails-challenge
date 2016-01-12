RACK_ENV = 'test' unless defined?(RACK_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")
require File.expand_path(File.dirname(__FILE__) + "/../config/globals")
require 'webmock/rspec'

Dir[File.expand_path(File.dirname(__FILE__) + "/../app/helpers/**/*.rb")].each(&method(:require))
Dir[File.expand_path(File.dirname(__FILE__) + "/../app/services/**/*.rb")].each(&method(:require))
Dir[File.expand_path(File.dirname(__FILE__) + "/support/*.rb")].each(&method(:require))

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  conf.include FactoryGirl::Syntax::Methods

  FactoryGirl.find_definitions

  conf.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    # pre_count will stop from truncating tables that were not used
    # use truncation for now, but deletion could be faster
    DatabaseCleaner.clean_with(:truncation, :pre_count => true)

    begin
      DatabaseCleaner.start
      FactoryGirl.lint
    ensure
      DatabaseCleaner.clean
    end
  end

  # need start/stop when using transaction cleaning so it knows
  # when to open the transaction
  conf.before do
    DatabaseCleaner.start
  end

  conf.after do
    DatabaseCleaner.clean
  end
end

# You can use this method to custom specify a Rack app
# you want rack-test to invoke:
#
#   app SalidoRailsChallenge::App
#   app SalidoRailsChallenge::App.tap { |a| }
#   app(SalidoRailsChallenge::App) do
#     set :foo, :bar
#   end
#
def app(app = nil, &blk)
  @app ||= block_given? ? app.instance_eval(&blk) : app
  @app ||= Padrino.application
end
