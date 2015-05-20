require_relative '../test_helper'
require_relative '../../app/controllers/rooms_controller'
require_relative '../../app/models/games_model'

describe RoomsController do
  describe ".all" do
    describe "if there are no rooms in the database" do
      before do
        clear_all
        GamesModel.create("Nashville Adventure","Bryan","Adventure")
      end
      it "should return an empty array" do
        assert_equal [], RoomsController.new.all(1)
      end
    end
    describe "if there are rooms" do
      before do
        clear_all
        GamesModel.create("Nashville Adventure","Bryan","Adventure")
        create_room(1, "kitchen","A nice place to eat")
        create_room(1, "bedroom","Large enough for a kingsized bed")
        create_room(1, "bathroom","The toilet could use a cleaning")
      end
      it "should return all the room info for all rooms in the order they were entered" do
        expected = [["kitchen","A nice place to eat"],["bedroom","Large enough for a kingsized bed"],["bathroom","The toilet could use a cleaning"]]
        actual = RoomsController.new.all(1)
        clear_all
        assert_equal expected, actual
      end
    end
  end

  describe ".count" do
    describe "if there are no rooms in the database" do
      before do
        clear_all
        GamesModel.create("Nashville Adventure","Bryan","Adventure")
      end
      it "should return 0" do
        assert_equal 0, RoomsController.new.count(1)
      end
    end
    describe "if there are rooms" do
      before do
        clear_all
        GamesModel.create("Nashville Adventure","Bryan","Adventure")
        create_room(1,"kitchen","A nice place to eat")
        create_room(1,"bedroom","Large enough for a kingsized bed")
        create_room(1,"bathroom","The toilet could use a cleaning")
      end
      it "should return the correct count" do
        rooms_count = RoomsController.new.count(1)
        clear_all
        assert_equal 3, rooms_count
      end
    end
  end
end
