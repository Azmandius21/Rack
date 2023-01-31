require 'byebug'

class App
  def call(env)
    [status(env), headers, body]
  end

  private

  def status(_env)
    200
  end

  def headers
    { 'Content type' => 'text/plain' }
  end

  def body
    ["\n"]
  end
end
