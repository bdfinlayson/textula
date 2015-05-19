require_relative '../../app/controllers/games_controller'
require_relative '../../app/controllers/players_controller'
require_relative '../../app/models/games_model'
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

  describe '.get_all_games' do
    let(:controller) {GamesController.new}
    let(:games_model) {GamesModel}
    it 'should get the names of all available games' do
      games_model.create("Nashville","Bryan","Adventure")
      games_model.create("Dallas","Sam","Adventure")
      games_model.create("Washington","Casey","Adventure")
      games_model.create("Space Invaders","Luke","Adventure")
      games = controller.get_all_games
      assert_equal 4, games.size
    end
  end

  describe '.find_game' do
    let(:controller) {GamesController.new}
    let(:games_model) {GamesModel}
    it 'should get all the game info for the desired game' do
      games_model.create("Nashville","Bryan","Adventure")
      games_model.create("Dallas","Sam","Adventure")
      games_model.create("Washington","Casey","Adventure")
      games_model.create("Space Invaders","Luke","Adventure")
      input = "Washington"
      result = controller.find_game(input)
      assert_equal [3,"Washington","Casey","Adventure"], result[0]
    end
  end

  describe '.parse_input' do
    let(:controller) {GamesController.new}
    let(:games_model) {GamesModel}
    it 'return the name of the found game in the array' do
      games_model.create("Nashville","Bryan","Adventure")
      games_model.create("Dallas","Sam","Adventure")
      games_model.create("Washington","Casey","Adventure")
      games_model.create("Space Invaders","Luke","Adventure")
      input = 4
      games = controller.get_all_games.flatten
      index = controller.find_game_name(input,games)
      assert_equal "Space Invaders", index
    end
  end
end
