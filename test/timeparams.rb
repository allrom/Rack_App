# This middleware requests and forms data:time reply

class Timeparams
  def initialize(app)
    @app = app
  end

  def call(env)
    allowed_params = %w[year month day hour minute second]
    request = Rack::Request.new(env)

    if request.path.match(/time/)
      input_params = request.params['format'].split(',')
      unknown_params = allowed_params + input_params - allowed_params & input_params

      if unknown_params.empty?
        datetime_params = input_params & allowed_params

        status, headers, response = @app.call(env)

        response_body = []
        datetime_params.each do |param|
          case param
          when 'year' then @year = response.first
          when 'month' then @month = response[1]
          when 'day' then @day = response[2]

          when 'hour' then @hour = response[3]
          when 'minute' then @minute = response[4]
          when 'second' then @second = response.last
          end
        end
        response_body << [@year, @month, @day].map(&:to_s).join('-') + ' '\
                       + [@hour, @minute, @second].map(&:to_s).join(':') + "\n"
        # clearing
        @year, @month, @day, @hour, @minute, @second = [""] * 6

        [status, headers, response_body]
      else
        [400, { 'Content-Type' => 'text/plain' }, ["\tUnknown Time format \[#{unknown_params.join(', ')}\]\n"]]
      end
    else
      [404, { 'Content-Type' => 'text/plain' }, ["\tPath is not found...\n"]]
    end
  end
end
