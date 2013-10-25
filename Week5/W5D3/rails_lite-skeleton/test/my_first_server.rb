require 'webrick'

server = WEBrick::HTTPServer.new :Port => 8080
trap('INT') { server.shutdown }

server.mount_proc '/' do |req, res|
  puts "Hello"
  res.content_type = 'text/text'
  res.body = req.path
  p req
  p res
end

server.start