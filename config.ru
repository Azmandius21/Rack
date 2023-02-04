require_relative 'app'

map = {
  '/time' => App.new
}

use Rack::Reloader, 0
use Rack::ContentType, 'text/plain'
run Rack::URLMap.new(map)
