require 'sinatra'

subscribers = []
get '/listen' do
  stream :keep_open do |subscriber|
    subscriber << "Welcome!\n"
    subscribers << subscriber
  end
end

get '/broadcast/:message' do
  message = params[:message]
  subscribers.each do |subscriber|
    subscriber << "#{Time.now}: #{message}\n"
  end
  "Message #{message} sent.\n"
end
