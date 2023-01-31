require_relative 'middleware/format_time'
require_relative 'middleware/logger'
require_relative 'app'

use Rack::Reloader, 0
use AppLogger, logdev: File.expand_path('log/app.log', __dir__)
use FormatTime
run App.new
