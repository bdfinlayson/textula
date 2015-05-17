require_relative '../../app/controllers/games_controller'
require_relative '../test_helper'

describe GameController do
  describe '.add_new_game' do
    let(:x) {Minitest.clear_games_table}
    let(:controller) {GameController.new}
    it "should add a game to the game table" do
      controller.game_name = "Nashville Adventure"
      controller.player_name = "Bryan"
      controller.game_description = "A game of cunning and adventure!"
      controller.add_new_game
      assert_equal controller.count, GameModel.count
    end
  end

  describe '.get_game_id' do
    let(:x) {Minitest.clear_games_table}
    let(:controller) {GameController.new}
    it "should get the id for the current game" do
      controller.game_name = "Nashville Adventure"
      controller.player_name = "Bryan"
      controller.game_description = "A game of cunning and adventure!"
      controller.add_new_game
      controller.game_id = controller.get_game_id
      assert_equal controller.game_id, GameModel.get_id(controller.game_name)
    end
  end
end
