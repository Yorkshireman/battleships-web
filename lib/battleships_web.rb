require 'sinatra/base'
require 'battleships'
require_relative 'game'
require_relative 'random_ships.rb'

class BattleshipsWeb < Sinatra::Base
  set :views, proc { File.join(root, '..', 'views') }

  # start the server if ruby file executed directly
  run! if app_file == $0

  get '/' do
    erb :index
  end

  get '/new_game' do
    erb :new_game
  end

  post '/game_page' do
    if params[:name] == ""
      @name = "Player1"
    else
      @name = params[:name]
    end
    $game = initialize_game
    $game.player_1.name = @name
    erb :game_page
  end

  post '/fire_shot' do
    @name = $game.player_1.name
    coordinates = (params[:coordinates]).upcase.to_sym
    get_result_and_set_variables(coordinates)
    erb :game_page
  end


  private

  def get_result_and_set_variables coordinates
    begin
      shot_result = $game.player_1.shoot coordinates
    rescue RuntimeError
      @coordinate_already_been_shot_at_or_out_of_bounds = true
    end

    if shot_result == :sunk
      @ship_sunk = true
      @hit = true
    elsif shot_result == :hit
      @hit = true
    else
      @hit = false
    end
  end

  def initialize_game
    game = Game.new Player, Board
    game.player_1.name = @name
    game
  end

end
