# To change this license header, choose License Headers in Project Properties.

class TimeApp
  def call(env)
    ## p self.class
    [status, headers, body]
  end

  private

  def status
    200
  end

  def headers
    { 'content-Type' => 'text/plain'}
  end

  def body
    ["\tRack is alive: from App...\n"]
  end
end
