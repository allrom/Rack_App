# Rack Up file

require_relative 'middleware/formatter'
require_relative 'middleware/timestamp'
require_relative 'time_app'

use Formatter
use Timestamp
run TimeApp.new
