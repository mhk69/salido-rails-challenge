RACK_ENV = 'test' unless defined?(RACK_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")
require File.expand_path(File.dirname(__FILE__) + "/../config/globals")
require 'webmock/rspec'

Dir[File.expand_path(File.dirname(__FILE__) + "/../app/helpers/**/*.rb")].each(&method(:require))
Dir[File.expand_path(File.dirname(__FILE__) + "/../app/services/**/*.rb")].each(&method(:require))
Dir[File.expand_path(File.dirname(__FILE__) + "/support/*.rb")].each(&method(:require))

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
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
