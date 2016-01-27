require 'sinatra'

enable :sessions

get '/' do
  session['value'] ||= "Hello, world!"
  hostname = Socket.gethostbyname(Socket.gethostname).first
  "Host: #{hostname}: The cookie you've created contains the value: #{session['value']}"
end

get '/slow' do
  sleep 10
  hostname = Socket.gethostbyname(Socket.gethostname).first
  "Host: #{hostname}: Slow response"
end