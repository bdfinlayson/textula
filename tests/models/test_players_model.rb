require_relative '../test_helper'
require_relative '../../app/models/players_model'

describe PlayersModel do
  describe '#create' do
    describe 'if one player is created' do
      before do
        PlayersModel.create(1,2,"Bryan")
      end
      it 'should count one player' do
        assert_equal 1, PlayersModel.count
      end
    end
  end
end

describe '#get_all_players' do
  describe 'multiple players' do
    before do
      PlayersModel.create(1,2,"Byran")
      PlayersModel.create(2,3,"Adam")
      PlayersModel.create(3,4,"Jill")
      PlayersModel.create(4,5,"Jen")
      PlayersModel.create(5,6,"John")
    end
    it 'should return a nested array of all players' do
      assert_equal [[1,1,2,"Byran"],[2,2,3,"Adam"],[3,3,4,"Jill"],[4,4,5,"Jen"],[5,5,6,"John"]], PlayersModel.get_all_players
    end
  end
  describe 'find single player' do
    before do
      PlayersModel.create(1,2,"Byran")
      PlayersModel.create(2,3,"Adam")
      PlayersModel.create(3,4,"Jill")
      PlayersModel.create(4,5,"Jen")
      PlayersModel.create(5,6,"John")
    end
    it 'should return all info for the desired player' do
      player_id = 4
      assert_equal [4,4,5,"Jen"], PlayersModel.find_player(player_id).flatten
    end
  end

  describe '#delete player' do
    describe 'deleting a player' do
      before do
      PlayersModel.create(1,2,"Byran")
      PlayersModel.create(2,3,"Adam")
      PlayersModel.create(3,4,"Jill")
      PlayersModel.create(4,5,"Jen")
      PlayersModel.create(5,6,"John")
      end
      it 'should delete a player' do
        PlayersModel.delete_player(4)
        assert_empty PlayersModel.find_player(4)
      end
    end
  end

  describe '#edit_player_location' do
    describe 'editing a player location' do
      before do
      PlayersModel.create(1,2,"Byran")
      PlayersModel.create(2,3,"Adam")
      PlayersModel.create(3,4,"Jill")
      PlayersModel.create(4,5,"Jen")
      PlayersModel.create(5,6,"John")
      end
      it 'should edit the player location' do
        PlayersModel.edit_player_location(3, 1)
        assert_equal [3,3,1,"Jill"], PlayersModel.find_player(3).flatten
      end
    end
  end


  describe '#edit_player_name' do
    describe 'editing a player name' do
      before do
      PlayersModel.create(1,2,"Byran")
      PlayersModel.create(2,3,"Adam")
      PlayersModel.create(3,4,"Jill")
      PlayersModel.create(4,5,"Jen")
      PlayersModel.create(5,6,"John")
      end
      it 'should edit the player name' do
        PlayersModel.edit_player_name(3, "James")
        assert_equal [3,3,4,"James"], PlayersModel.find_player(3).flatten
      end
    end
  end
end

