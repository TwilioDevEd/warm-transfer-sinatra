ENV['RACK_ENV'] = 'test'
ENV['APP_ENV'] = 'test'

require_relative File.join('..', 'app')

RSpec.configure do |config|
  include Rack::Test::Methods

  def app
    WarmTransfer::App
  end
end
