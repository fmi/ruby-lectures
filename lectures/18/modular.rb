require 'sinatra/base'

class Welcome < Sinatra::Base
  get '/' do
    'Welcome to modular Sinatra!'
  end

  run!
end
