# This file is used by Rack-based servers to start the application.

require 'rack-zippy'

asset_root = 'public'
use Rack::Zippy::AssetServer, asset_root

require ::File.expand_path('../config/environment', __FILE__)

use Rack::CanonicalHost, 'www.coderfactoryacademy.edu.au'
run Rails.application
