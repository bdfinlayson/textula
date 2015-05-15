require_relative '../test_helper'
require_relative '../../app/controllers/rooms_controller'

describe RoomsController do
  describe ".all" do
    describe "if there are no rooms in the database" do
      before do
        clear_table
      end
      it "should return an empty array" do
        assert_equal [], RoomsController.new.all
      end
    end
    describe "if there are rooms" do
      before do
        clear_table
        create_room("kitchen","A nice place to eat")
        create_room("bedroom","Large enough for a kingsized bed")
        create_room("bathroom","The toilet could use a cleaning")
      end
      it "should return all the room info for all rooms in the order they were entered" do
        expected = [["kitchen","A nice place to eat"],["bedroom","Large enough for a kingsized bed"],["bathroom","The toilet could use a cleaning"]]
        actual = RoomsController.new.all
        assert_equal expected, actual
      end
    end
  end

  describe ".count" do
    describe "if there are no rooms in the database" do
      before do
        clear_table
      end
      it "should return 0" do
        assert_equal 0, RoomsController.new.count
      end
    end
    describe "if there are rooms" do
      before do
        clear_table
        create_room("kitchen","A nice place to eat")
        create_room("bedroom","Large enough for a kingsized bed")
        create_room("bathroom","The toilet could use a cleaning")
      end
      it "should return the correct count" do
        assert_equal 3, RoomsController.new.count
      end
    end
  end
end
