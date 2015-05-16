require_relative '../test_helper'
require_relative '../../app/controllers/game_controller'

describe GameController do
  describe '.add_new_game' do
    let(:x) {Minitest.clear_games_table}
    let(:controller) {GameController.new}
    it "should add a game to the game table" do
      controller.game_name = "Nashville Adventure"
      controller.player_name = "Bryan"
      controller.game_description = "A game of cunning and adventure!"
      controller.add_new_game
      assert_equal 1, GameModel.count
    end
  end
end
