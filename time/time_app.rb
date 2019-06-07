# To change this license header, choose License Headers in Project Properties.
#
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
    @year, @month, @day, @hour, @minute, @second = [""] * 6
    response_body = []

    if frmt.valid?
      fyear, fmonth, fday, fhour, fminute, fsecond = frmt.formatted_time

      frmt.work_formats.each do |format|
        case format
        when 'year' then @year = fyear
        when 'month' then @month = fmonth
        when 'day' then @day = fday

        when 'hour' then @hour = fhour
        when 'minute' then @minute = fminute
        when 'second' then @second = fsecond
        end
      end

      response_body << [@year, @month, @day].map(&:to_s).join('-') + ' '\
                       + [@hour, @minute, @second].map(&:to_s).join(':') + "\n"

      [200, { 'Content-Type' => 'text/plain' }, response_body]
    else
      [400, { 'Content-Type' => 'text/plain' },
       ["\tUnknown Time format(s) \[#{frmt.unknown_formats.join(', ')}\]\n"]]
    end
  end
end
