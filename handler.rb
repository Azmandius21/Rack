require 'rack'

app = proc do |_env|
  [
    200,
    { 'Content type' => 'text/plain' },
    ["Helow Dolly\n"]
  ]
end

Rack::Handler::WEBrick.run app
