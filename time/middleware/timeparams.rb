# To change this license header, choose License Headers in Project Properties.

class Timestamp
  def initialize(app)
    @app = app
  end

  def call(env)
    ## p self.class
    env[:timestamp] = Time.now
    ## @app.call(env)
    status, headers, body = @app.call(env)
  end
end
