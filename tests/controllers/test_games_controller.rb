require_relative '../../app/controllers/games_controller'
require_relative '../../app/controllers/players_controller'
require_relative '../../lib/database'
require_relative '../test_helper'

describe GamesController do
  describe '.add_new_game' do
    let(:x) {Minitest.clear_all}
    let(:controller) {GamesController.new}
    it "should add a game to the game table" do
      controller.game_name = "Nashville Adventure"
      controller.player_name = "Bryan"
      controller.game_description = "A game of cunning and adventure!"
      controller.add_new_game
      assert_equal controller.count, GamesModel.count
    end
  end

  describe '.get_game_id' do
    let(:x) {Minitest.clear_all}
    let(:controller) {GamesController.new}
    it "should get the id for the current game" do
      controller.game_name = "Nashville Adventure"
      controller.player_name = "Bryan"
      controller.game_description = "A game of cunning and adventure!"
      controller.add_new_game
      controller.game_id = controller.get_game_id
      assert_equal controller.game_id, GamesModel.get_id(controller.game_name)
    end
  end

  describe '.play' do
    let(:x) {Minitest.clear_all}
    let(:controller) {GamesController.new}
    it "playing a game should initialize a new player" do
      controller.game_name = "Nashville Adventure"
      controller.player_name = "Bryan"
      controller.game_description = "A game of cunning and adventure!"
      controller.add_new_game
      controller.play
      name = Database.execute("select player_name from players limit 1")
      assert_equal "Bryan",name[0][0]
    end
  end
end
