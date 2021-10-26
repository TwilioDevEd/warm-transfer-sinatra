require 'dotenv'
require 'sinatra'
require "sinatra/json"
require 'sinatra/config_file'
require 'tilt/haml'
require_relative 'helpers/datamapper_helper'
require_relative 'helpers/request_helper'
require_relative 'routes/conference'
require_relative 'routes/token'
require_relative 'lib/twilio_capability'
require_relative 'lib/twiml_generator'
require_relative 'lib/caller'

# Load environment configuration
Dotenv.load

# Set the environment after dotenv loads
# Default to production
environment = (ENV['APP_ENV'] || ENV['RACK_ENV'] || :production).to_sym
set :environment, environment

require 'bundler'
Bundler.require :default, environment

module WarmTransfer
  class App < Sinatra::Base
    register Sinatra::ConfigFile
    config_file 'config/app.yml'
    DataMapperHelper.setup(settings.database_url)
    set :root, File.dirname(__FILE__)
    register Routes::Conference
    register Routes::Token

    get '/' do
      haml :home
    end
  end
end
