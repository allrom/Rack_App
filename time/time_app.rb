# To change this license header, choose License Headers in Project Properties.

class TimeApp
  def call(env)
    [status, headers, body]
  end

  private

  def status
    200
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def body
    timestamp = Time.now
    timestamp.strftime('%Y,%m,%d,%H,%M,%S').split(',')
  end
end
