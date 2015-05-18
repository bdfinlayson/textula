require_relative '../test_helper'
require_relative '../../app/controllers/games_controller'
require_relative '../../app/controllers/players_controller'
require_relative '../../app/models/games_model'

describe PlayersController do
  describe '.create' do
    let(:x) {Minitest.clear_all}
    let(:controller) {PlayersController.new(1,"living room","Bryan")}
    let(:games) {GamesController.new}
    it "should add a player to the players table" do
      controller.create
      player_count = PlayersModel.count
      assert_equal 1, player_count
    end
  end
end

