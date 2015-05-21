require_relative '../test_helper'
require_relative '../../app/models/rooms_model'

describe RoomsModel do
  describe '#get_rooms' do
    describe 'get all room names for a game' do
      before do
        RoomsModel.create(1,'kitchen','nice','You are in a','You can see','You can go')
        RoomsModel.create(1,'living room','ugly','You are in a','You can see','You can go')
        RoomsModel.create(1,'attic','quiet','You are in a','You can see','You can go')
        RoomsModel.create(1,'dining room','pretty','You are in a','You can see','You can go')
        RoomsModel.create(2,'bedroom','dirty','You are in a','You can see','You can go')
        RoomsModel.create(2,'hall','nice','You are in a','You can see','You can go')
        RoomsModel.create(2,'tower','dusty','You are in a','You can see','You can go')
      end
      it 'should return the rooms for the game' do
        assert_equal ['bedroom','hall','tower'], RoomsModel.get_rooms(2)
      end
    end
  end

  describe '#create' do
    describe 'creating a room' do
      before do
        RoomsModel.create(1,'kitchen','nice','You are in a','You can see','You can go')
        RoomsModel.create(1,'living room','ugly','You are in a','You can see','You can go')
        RoomsModel.create(1,'attic','quiet','You are in a','You can see','You can go')
        RoomsModel.create(1,'dining room','pretty','You are in a','You can see','You can go')
        RoomsModel.create(2,'bedroom','dirty','You are in a','You can see','You can go')
        RoomsModel.create(2,'hall','nice','You are in a','You can see','You can go')
        RoomsModel.create(2,'tower','dusty','You are in a','You can see','You can go')
      end
      it 'should count the correct number of games' do
        assert_equal 4, RoomsModel.count(1)[0][0]
      end
    end
  end

  describe '#is_start_of_game?' do
    describe 'start of game' do
    end
    it 'should count zero if start of game' do
      assert_equal 0, RoomsModel.is_start_of_game?(4)
    end
  end

  describe '#add_placeholder' do
    describe 'creating a placeholder' do
      before do
        RoomsModel.create(1,'kitchen','nice','You are in a','You can see','You can go')
        RoomsModel.create(1,'living room','ugly','You are in a','You can see','You can go')
        RoomsModel.create(1,'attic','quiet','You are in a','You can see','You can go')
        RoomsModel.create(1,'dining room','pretty','You are in a','You can see','You can go')
        RoomsModel.create(2,'bedroom','dirty','You are in a','You can see','You can go')
        RoomsModel.create(2,'hall','nice','You are in a','You can see','You can go')
        RoomsModel.create(2,'tower','dusty','You are in a','You can see','You can go')
      end
      it 'should add a placeholder room' do
        RoomsModel.add_placeholder(2, "library")
        assert_equal 4, RoomsModel.count(2)[0][0]
      end
    end
  end

  describe '#insert_follow_up' do
    describe 'updating the placeholder' do
      before do
        RoomsModel.create(1,'kitchen','nice','You are in a','You can see','You can go')
        RoomsModel.create(1,'living room','ugly','You are in a','You can see','You can go')
        RoomsModel.create(1,'attic','quiet','You are in a','You can see','You can go')
        RoomsModel.create(1,'dining room','pretty','You are in a','You can see','You can go')
        RoomsModel.create(2,'bedroom','dirty','You are in a','You can see','You can go')
        RoomsModel.create(2,'hall','nice','You are in a','You can see','You can go')
        RoomsModel.create(2,'tower','dusty','You are in a','You can see','You can go')
        RoomsModel.add_placeholder(2, "library")
      end
      it 'should update the placeholder' do
        RoomsModel.insert_follow_up(2,"library","dull place","You are in the","You can see","You can go")
        assert_equal [8,2,"library","dull place","You are in the","You can see","You can go"], RoomsModel.get_all_room_info(8,2).flatten
      end
    end
  end

  describe '#get_all_room_info' do
    describe 'getting all room info for a game' do
      before do
        RoomsModel.create(1,'attic','quiet','You are in a','You can see','You can go')
        RoomsModel.create(1,'dining room','pretty','You are in a','You can see','You can go')
        RoomsModel.create(2,'bedroom','dirty','You are in a','You can see','You can go')
        RoomsModel.create(2,'hall','nice','You are in a','You can see','You can go')
      end
      it 'should return all the room info for a game' do
        assert_equal [['bedroom','dirty'],['hall','nice']], RoomsModel.get_all_rooms_info(2)
      end
    end
  end

  describe '#edit_room_name' do
    describe 'edit the room name' do
      before do
        RoomsModel.create(1,'attic','quiet','You are in a','You can see','You can go')
        RoomsModel.create(1,'dining room','pretty','You are in a','You can see','You can go')
        RoomsModel.create(2,'bedroom','dirty','You are in a','You can see','You can go')
        RoomsModel.create(2,'hall','nice','You are in a','You can see','You can go')
      end
      it 'should edit the room name' do
        RoomsModel.edit_room_name(2,'living room', 'hall')
        assert_equal 'living room', RoomsModel.get_room(4)[0][0]
      end
    end
  end

  describe '#edit_room_description' do
    describe 'edit room description' do
      before do
        RoomsModel.create(1,'attic','quiet','You are in a','You can see','You can go')
        RoomsModel.create(1,'dining room','pretty','You are in a','You can see','You can go')
        RoomsModel.create(2,'bedroom','dirty','You are in a','You can see','You can go')
        RoomsModel.create(2,'hall','nice','You are in a','You can see','You can go')
      end
      it 'should edit the room description' do
        RoomsModel.edit_room_description(3,'sparkling clean','dirty')
        assert_equal 'sparkling clean', RoomsModel.get_description(3)[0][0]
      end
    end
  end

  describe '#edit_room_description_prefix' do
    describe 'edit room description prefix' do
      before do
        RoomsModel.create(1,'attic','quiet','You are in a','You can see','You can go')
        RoomsModel.create(1,'dining room','pretty','You are in a','You can see','You can go')
        RoomsModel.create(2,'bedroom','dirty','You are in a','You can see','You can go')
        RoomsModel.create(2,'hall','nice','You are in a','You can see','You can go')
      end
      it 'should edit the room description prefix' do
        RoomsModel.edit_room_description_prefix(3,'You are in the','You are in a')
        assert_equal 'You are in the', RoomsModel.get_description_prefix(3)[0][0]
      end
    end
  end

  describe '#edit_room_objects_prefix' do
    describe 'edit room objects prefix' do
      before do
        RoomsModel.create(1,'attic','quiet','You are in a','You can see','You can go')
        RoomsModel.create(1,'dining room','pretty','You are in a','You can see','You can go')
        RoomsModel.create(2,'bedroom','dirty','You are in a','You can see','You can go')
        RoomsModel.create(2,'hall','nice','You are in a','You can see','You can go')
      end
      it 'should edit the room objects prefix' do
        RoomsModel.edit_room_objects_prefix(3,'You can feel')
        assert_equal 'You can feel', RoomsModel.get_objects_prefix(3)[0][0]
      end
    end
  end

  describe '#edit_room_exits_prefix' do
    describe 'edit room exits prefix' do
      before do
        RoomsModel.create(1,'attic','quiet','You are in a','You can see','You can go')
        RoomsModel.create(1,'dining room','pretty','You are in a','You can see','You can go')
        RoomsModel.create(2,'bedroom','dirty','You are in a','You can see','You can go')
        RoomsModel.create(2,'hall','nice','You are in a','You can see','You can go')
      end
      it 'should edit the room exit prefix' do
        RoomsModel.edit_room_exits_prefix(3,'You can crawl under')
        assert_equal 'You can crawl under', RoomsModel.get_exits_prefix(3)[0][0]
      end
    end
  end
end
