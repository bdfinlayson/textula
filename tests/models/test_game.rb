require_relative '../test_helper'
require_relative '../../app/controllers/games_controller'
require_relative '../../app/models/game'

describe Game do
  describe '#create' do
    describe 'creating a new game' do
      before do
        Game.create("NSS", "Bryan", "Adventure game in tech")
      end
      it 'should create a game in the games table' do
        assert_equal 1, Game.count
      end
    end
  end

  describe '#get_id' do
    describe 'getting a game id' do
      before do
        Game.create("Rage", "Bryan", "music")
        Game.create("Road", "Casey", "sports")
        Game.create("Grand Theft", "James", "action")
        Game.create("Guitar Hero", "Ron", "adventure")
        Game.create("Road Rage", "Smith", "thriller")
        Game.create("Ninja Turtles", "Adam", "mystery")
      end
      it "should get the correct game id" do
        assert_equal 5, Game.get_id("Road Rage")[0][0]
      end
    end
  end

  describe '#get_all_games' do
    describe 'getting all games' do
      before do
        Game.create("Rage", "Bryan", "music")
        Game.create("Road", "Casey", "sports")
        Game.create("Guitar Hero", "Ron", "adventure")
      end
      it 'should get all games in database' do
        assert_equal [["Rage"],["Road"],["Guitar Hero"]], Game.get_all_games
      end
    end
  end

  describe '#find_game' do
    describe 'getting a single game' do
      before do
        Game.create("Rage", "Bryan", "music")
        Game.create("Road", "Casey", "sports")
        Game.create("Grand Theft", "James", "action")
        Game.create("Guitar Hero", "Ron", "adventure")
        Game.create("Road Rage", "Smith", "thriller")
        Game.create("Ninja Turtles", "Adam", "mystery")
      end
      it 'should return the desired game' do
        assert_equal [[3,"Grand Theft","James","action"]], Game.find_game("Grand Theft")
      end
    end
  end

  describe '#edit_game_description' do
    describe 'editing a game description' do
      before do
        Game.create("Rage", "Bryan", "music")
        Game.create("Road", "Casey", "sports")
        Game.create("Grand Theft", "James", "action")
        Game.create("Guitar Hero", "Ron", "adventure")
        Game.create("Road Rage", "Smith", "thriller")
        Game.create("Ninja Turtles", "Adam", "mystery")
      end
      it 'should edit the correct game' do
        Game.edit_game_description(3, "thriller")
        assert_equal [[3,"Grand Theft","James","thriller"]], Game.find_game("Grand Theft")
      end
    end
  end

  describe '#edit_game_name' do
    describe 'editing a game name' do
      before do
        Game.create("Rage", "Bryan", "music")
        Game.create("Road", "Casey", "sports")
        Game.create("Grand Theft", "James", "action")
        Game.create("Guitar Hero", "Ron", "adventure")
        Game.create("Road Rage", "Smith", "thriller")
        Game.create("Ninja Turtles", "Adam", "mystery")
      end
      it 'should edit the game name' do
        Game.edit_game_name(2,"Nashville Adventure")
        assert_equal [[2,"Nashville Adventure","Casey","sports"]], Game.find_game("Nashville Adventure")
      end
    end
  end

  describe '#delete_game' do
    describe 'deleting a game' do
      before do
        Game.create("Rage", "Bryan", "music")
        Game.create("Road", "Casey", "sports")
        Game.create("Grand Theft", "James", "action")
        Game.create("Guitar Hero", "Ron", "adventure")
        Game.create("Road Rage", "Smith", "thriller")
        Game.create("Ninja Turtles", "Adam", "mystery")
      end
      it 'should delete the game' do
        Game.delete_game(3)
        assert_empty Game.find_game("Grand Theft")
      end
    end
  end
end
