# Rack Up init file

require_relative 'middleware/log_formatter'
require_relative 'time_formatter'
require_relative 'time_app'

use LogFormatter
run TimeApp.new
