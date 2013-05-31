require './coolster_app'

if ENV['RACK_ENV'] == 'development'
  IDEARATOR_DOMAIN = "localhost:3000"
  IDEARATOR_URL = "http://" + IDEARATOR_DOMAIN
elsif ENV['RACK_ENV'] == 'production'
  IDEARATOR_DOMAIN = ENV['IDEARATOR_DOMAIN']
  IDEARATOR_URL = "http://" + IDEARATOR_DOMAIN
end

use Rack::Session::Cookie, :key => '_Sprint0_session', :secret => ENV['SESSION_SECRET_TOKEN']


use Warden::Manager do |manager|
  manager.failure_app = CoolsterApp
  manager.default_scope = 'user'
end

Warden::Manager.before_failure do |env, opts|
  env['REQUEST_METHOD'] = "POST"
end

run CoolsterApp

