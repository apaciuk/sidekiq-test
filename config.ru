
require 'sidekiq'

Sidekiq.configure_client do |config| 
    config.redis = { url: 'redis://localhost:6379/1' }
end

require 'sidekiq/web' 
require 'rack'

use Rack::Session::Cookie, secret: File.read(".session.key"), same_site: true, max_age: 86400
run Sidekiq::Web