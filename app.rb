require 'sinatra/base'
require_relative 'routes/conference'

ENV['RACK_ENV'] ||= 'development'

require 'bundler'
Bundler.require :default, ENV['RACK_ENV'].to_sym

module WarmTransfer
  class App < Sinatra::Base
    set :root, File.dirname(__FILE__)
    register Routes::Conference

    get '/' do
      haml :home
    end
  end
end
