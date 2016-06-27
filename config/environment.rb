# Load the Rails application.
require File.expand_path('../application', __FILE__)

config.middleware.use Rack::SslEnforcer

# Initialize the Rails application.
Rails.application.initialize!
