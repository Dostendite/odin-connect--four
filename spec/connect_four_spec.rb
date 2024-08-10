require_relative "../lib/connect_four"
require_relative "../lib/cell"
# Since this is probably your first experience with TDD, let's extend the
# workflow to include a few more steps:
# 1. Read & understand the requirement for one method only.
# 2. Write one test for that method; run the tests to see it fail.
# 3. Write the method to fulfill the requirement.
# 4. Run the tests again. If they don't all pass, redo steps 1-3.
# 5. When your first test is passing, write the additional tests.
# 6. Run all of the tests. If any do not pass, redo steps 3-5.
# 7. Optional: Refactor your code and/or tests, keeping all tests passing.

def get_nested_array_length(ary)
  counter = 0
  ary.each { |row| row.each { |_| counter += 1 } }
  counter
end

RSpec.describe ConnectFour do
  describe "#create_cell" do
    subject(:connect_four) { described_class.new }

    it "creates a cell" do
      new_cell = connect_four.create_cell
      expect(new_cell).to be_a Cell
    end

    context "when the cell is blue" do
      it "creates a blue cell" do
        new_cell = connect_four.create_cell("blue")
        expect(new_cell.color).to eq("blue")
      end
    end
    context "when the cell is orange" do
      it "creates an orange cell" do
        new_cell = connect_four.create_cell("orange")
        expect(new_cell.color).to eq("orange")
      end
    end
  end

  describe "#create_board" do
    subject(:connect_four) { described_class.new }

    it "creates a 6x7 board" do
      game_board = connect_four.create_board
      demo_board = Array.new(6) { Array.new(7) }
      expect(game_board).to eq(demo_board)
    end

    it "creates a board with 42 elements" do
      game_board = connect_four.create_board
      game_board_length = get_nested_array_length(game_board)

      expect(game_board_length).to eq(42)
    end
  end
end
