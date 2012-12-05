require 'sinatra'

get '/stream' do
  stream do |connection|
    connection << "Start of the stream\n"
    sleep 1
    connection << "Some more data\n"
    sleep 1
    connection << "And even more data\n"
  end
end
