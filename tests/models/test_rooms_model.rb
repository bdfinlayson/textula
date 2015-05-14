require_relative '../test_helper'
require_relative '../../app/controllers/rooms_controller'

describe RoomsController do
  describe ".all" do
    describe "if there are no rooms in the database" do
      it "should return an empty array" do
        assert_equal [], RoomsController.new.all
      end
    end
    describe "if there are rooms" do
      before do
        create_room("kitchen","A nice place to eat")
        create_room("bedroom","Large enough for a kingsized bed")
        create_room("bathroom","The toilet could use a cleaning")
      end
      it "should return an array" do
        assert_equal Array, RoomsController.all.class
      end
      it "should return all the room info for all rooms in the order they were entered" do
        expected = [[1,"kitchen","A nice place to eat"],[2,"bedroom","Large enough for a kingsized bed"],["bathroom","The toilet could use a cleaning"]]
        actual = RoomsController.all
        assert_equal expected, actual
      end
    end
  end

  describe "#count" do
    describe "if there are no rooms in the database" do
      it "should return 0" do
        assert_equal 0, RoomsController.count
      end
    end
    describe "if there are rooms" do
      before do
        create_room("kitchen","A nice place to eat")
        create_room("bedroom","Large enough for a kingsized bed")
        create_room("bathroom","The toilet could use a cleaning")
      end
      it "should return the correct count" do
        assert_equal 3, RoomsController.count
      end
    end
  end
end
