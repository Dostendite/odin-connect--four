require_relative "../lib/connect_four"
require_relative "../lib/cell"

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

  describe "#out_of_bounds?" do
    subject(:connect_four) { described_class.new }

    context "when the row or column are below 1" do
      it "returns true when the row is below 1" do
        target_row = 0
        target_column = 5
        bounds_test = connect_four.out_of_bounds?(target_row, target_column)
        expect(bounds_test).to be true
      end

      it "returns true when the column is below 1" do
        target_row = 3
        target_column = -2
        bounds_test = connect_four.out_of_bounds?(target_row, target_column)
        expect(bounds_test).to be true
      end

      it "returns true when both are below 1" do
        target_row = -5
        target_column = -2
        bounds_test = connect_four.out_of_bounds?(target_row, target_column)
        expect(bounds_test).to be true
      end
    end

    context "when the row or column are positive" do
      it "returns true when row is higher than 6" do
        target_row = 7
        target_column = 3
        bounds_test = connect_four.out_of_bounds?(target_row, target_column)
        expect(bounds_test).to be true
      end

      it "returns true when column is higher than 7" do
        target_row = 5
        target_column = 8
        bounds_test = connect_four.out_of_bounds?(target_row, target_column)
        expect(bounds_test).to be true
      end
    end
  end
end
