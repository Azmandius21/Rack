require_relative 'format_time'

class App
  def call(env)
    request = Rack::Request.new(env)
    result = FormatTime.new(request)

    if result.valid?
      body = result.time
      status = 200
    else

      body = ["Unknown format: #{result.format_mistake}\n"]
      status = 400
    end

    Rack::Response.new(body, status, {}).finish
  end
end
