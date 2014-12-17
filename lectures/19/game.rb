require 'sinatra'

weaker_moves = {rock: :scissors, paper: :rock, scissors: :paper}
valid_moves  = weaker_moves.keys

before do
  content_type :txt
end

get '/play/:move' do
  player_move = params[:move].to_sym

  unless valid_moves.include?(player_move)
    halt 403, "You must throw one of the following: #{valid_moves.join(', ')}"
  end

  computer_move = weaker_moves.keys.sample

  if player_move == computer_move
    "Oh, my!\nIt's a tie!"
  elsif computer_move == weaker_moves[player_move]
    "Nicely done, #{player_move} beats #{computer_move}!"
  else
    "Ouch... You got trashed, #{computer_move} beats #{player_move}. Better luck next time!"
  end
end
