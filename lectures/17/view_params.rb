require 'sinatra'

get '/posts/:id' do
  @info = "This is post ID #{params[:id]}"
  erb :post, locals: {title: 'My Blog'}
end

__END__

@@post
<h1><%= title %></h1>
<p><%= @info %></p>
