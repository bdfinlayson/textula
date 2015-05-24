require_relative '../models/player'

class PlayersController
  attr_accessor :location, :game_id, :player_name

  def initialize(game_id,location,player_name)
    @location = location
    @game_id = game_id
    @player_name = player_name
  end

  def create
    Player.create(@game_id,@location,@player_name)
  end

  def count
    Player.count
  end
end
