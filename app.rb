require 'sinatra/base'
require_relative 'routes/conference'
require_relative 'routes/token'
require_relative 'lib/twilio_capability'

ENV['RACK_ENV'] ||= 'development'

require 'bundler'
Bundler.require :default, ENV['RACK_ENV'].to_sym

module WarmTransfer
  class App < Sinatra::Base
    set :root, File.dirname(__FILE__)
    register Routes::Conference
    register Routes::Token

    get '/' do
      haml :home
    end
  end
end
