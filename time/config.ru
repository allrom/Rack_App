# Rack Up init file

require_relative 'middleware/formatter'
require_relative 'middleware/timeparams'
require_relative 'time_app'

use Timeparams
use Formatter
run TimeApp.new
