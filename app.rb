require 'sinatra/base'

ENV['RACK_ENV'] ||= 'development'

require 'bundler'
Bundler.require :default, ENV['RACK_ENV'].to_sym

module WarmTransfer
  class App < Sinatra::Base
    set :root, File.dirname(__FILE__)

    get '/' do
      haml :home
    end
  end
end
