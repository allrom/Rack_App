# To change this license header, choose License Headers in Project Properties.
#
require_relative 'time_formatter'

class TimeApp
  def call(env)
    request = Rack::Request.new(env)

    if request.path.match(/time/)
      input_params = request.params['format']

      time_response(input_params)
    else
      [404, { 'Content-Type' => 'text/plain' }, ["\tPath is not found...\n"]]
    end
  end

  def time_response(params)
    frmt = TimeFormatter.new(params)

    if frmt.valid?
      body = frmt.formatted_response
      [200, { 'Content-Type' => 'text/plain' }, body]
    else
      [400, { 'Content-Type' => 'text/plain' },
       ["\tUnknown Time format(s) \[#{frmt.unknown_formats.join(', ')}\]\n"]]
    end
  end
end
