$:.unshift(File.dirname(__FILE__))
require 'bundler'
Bundler.require
set :environment, ENV['RACK_ENV'].to_sym

require 'config/environment'
require 'rack/contrib'
require 'tilt/haml'
require 'haml'

map '/assets' do
  sprockets = Sprockets::Environment.new
  sprockets.append_path 'assets/images'
  sprockets.append_path 'assets/javascripts'
  sprockets.append_path 'assets/stylesheets'
  Sprockets::Helpers.configure do |config|
    config.environment = sprockets
    config.prefix = "/assets"
    config.digest = true
  end
  run sprockets
end

map '/' do
  run CodesV1
end