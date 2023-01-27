require 'rack'

app = Proc.new do |env|
  [
    200, 
   {"Content type" => "text/plain"},
   ["Helow Dolly\n"]
  ]
end

Rack::Handler::WEBrick.run app