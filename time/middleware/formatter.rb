# To change this license header, choose License Headers in Project Properties.
# This middleware formats web-server console output

class Formatter
  def initialize(app)
    @app = app
  end

  def call(env)
    puts format_env(env)
    @app.call(env)
  end

  def format(heading, pairs)
    [heading, ' ', format_pairs(pairs), "\n"].join("\n")
  end

  def format_pairs(pairs)
    pairs.map { |key, val| ' ' + [key, val.inspect].join(': ') }
  end

  def req_http_headers(env)
    env.select { |key, _val| key.include?('HTTP_') }
  end

  def web_server_info(env)
    env.reject { |key, _val| key.include?('HTTP_') || key.include?('rack.') }
  end

  def format_env(env)
    puts format('Request HTTP headers', req_http_headers(env))
    puts format('Web Server headers', web_server_info(env))
  end
end
