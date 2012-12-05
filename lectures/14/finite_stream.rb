require 'sinatra'

get '/stream' do
  stream do |connection|
    connection << "Start of the stream\n"
    sleep 3
    connection << "Some more data\n"
    sleep 3
    connection << "And even more data\n"
  end
end
