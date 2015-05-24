require_relative '../test_helper'
require_relative '../../app/models/player'

describe Player do
  describe '#create' do
    describe 'if one player is created' do
      before do
        Player.create(1,2,"Bryan")
      end
      it 'should count one player' do
        assert_equal 1, Player.count
      end
    end
  end
end

describe '#get_all_players' do
  describe 'multiple players' do
    before do
      Player.create(1,2,"Byran")
      Player.create(2,3,"Adam")
      Player.create(3,4,"Jill")
      Player.create(4,5,"Jen")
      Player.create(5,6,"John")
    end
    it 'should return a nested array of all players' do
      assert_equal [[1,1,2,"Byran"],[2,2,3,"Adam"],[3,3,4,"Jill"],[4,4,5,"Jen"],[5,5,6,"John"]], Player.get_all_players
    end
  end
  describe 'find single player' do
    before do
      Player.create(1,2,"Byran")
      Player.create(2,3,"Adam")
      Player.create(3,4,"Jill")
      Player.create(4,5,"Jen")
      Player.create(5,6,"John")
    end
    it 'should return all info for the desired player' do
      player_id = 4
      assert_equal [4,4,5,"Jen"], Player.find_player(player_id).flatten
    end
  end

  describe '#delete player' do
    describe 'deleting a player' do
      before do
      Player.create(1,2,"Byran")
      Player.create(2,3,"Adam")
      Player.create(3,4,"Jill")
      Player.create(4,5,"Jen")
      Player.create(5,6,"John")
      end
      it 'should delete a player' do
        Player.delete_player(4)
        assert_empty Player.find_player(4)
      end
    end
  end

  describe '#edit_player_location' do
    describe 'editing a player location' do
      before do
      Player.create(1,2,"Byran")
      Player.create(2,3,"Adam")
      Player.create(3,4,"Jill")
      Player.create(4,5,"Jen")
      Player.create(5,6,"John")
      end
      it 'should edit the player location' do
        Player.edit_player_location(3, 1)
        assert_equal [3,3,1,"Jill"], Player.find_player(3).flatten
      end
    end
  end


  describe '#edit_player_name' do
    describe 'editing a player name' do
      before do
      Player.create(1,2,"Byran")
      Player.create(2,3,"Adam")
      Player.create(3,4,"Jill")
      Player.create(4,5,"Jen")
      Player.create(5,6,"John")
      end
      it 'should edit the player name' do
        Player.edit_player_name(3, "James")
        assert_equal [3,3,4,"James"], Player.find_player(3).flatten
      end
    end
  end
end

