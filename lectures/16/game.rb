require 'sinatra'

before do
  content_type :txt
  @moves = {rock: :scissors, paper: :rock, scissors: :paper}
end

get '/play/:move' do
  # Be wary when calling #to_sym on random strings!
  player_move = params[:move].to_sym

  unless @moves.key?(player_move)
    valid_moves = @moves.keys.map(&:to_s).join(', ')
    halt 403, "You must throw one of the following: #{valid_moves}"
  end

  computer_move = @moves.keys.sample

  if player_move == computer_move
    "Oh, my!\nIt's a tie!"
  elsif computer_move == @moves[player_move]
    "Nicely done, #{player_move} beats #{computer_move}!"
  else
    "Ouch... You got trashed, #{computer_move} beats #{player_move}. Better luck next time!"
  end
end
