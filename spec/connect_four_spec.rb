require "pry-byebug"

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

  describe "#drop_cell" do
    subject(:connect_four) { described_class.new }

    context "when there are no cells below" do
      it "drops the cell into the column 4" do
        target_row = 6
        target_column = 4

        test_cell = connect_four.create_cell("blue")
        connect_four.drop_cell(test_cell, target_column)

        game_board = connect_four.instance_variable_get(:@game_board)
        target_space = game_board[target_row - 1][target_column - 1]

        expect(target_space).to eq(test_cell)
      end

      it "drops the cell into the column 6" do
        target_row = 6
        target_column = 6

        test_cell = connect_four.create_cell("orange")
        connect_four.drop_cell(test_cell, target_column)

        game_board = connect_four.instance_variable_get(:@game_board)
        target_space = game_board[target_row - 1][target_column - 1]

        expect(target_space).to eq(test_cell)
      end
    end

    context "when there is a cell below" do
      it "drops the cell into the row above [5, 4]" do
        target_row = 5
        target_column = 4

        test_cell = connect_four.create_cell("orange")
        test_cell_two = connect_four.create_cell("blue")

        connect_four.drop_cell(test_cell, target_column)
        connect_four.drop_cell(test_cell_two, target_column)

        game_board = connect_four.instance_variable_get(:@game_board)
        target_space = game_board[target_row - 1][target_column - 1]

        expect(target_space).to eq(test_cell_two)
      end

      it "drops the cell into the row above [5, 7]" do
        target_row = 5
        target_column = 7

        test_cell = connect_four.create_cell("orange")
        test_cell_two = connect_four.create_cell("blue")

        connect_four.drop_cell(test_cell, target_column)
        connect_four.drop_cell(test_cell_two, target_column)

        game_board = connect_four.instance_variable_get(:@game_board)
        target_space = game_board[target_row - 1][target_column - 1]

        expect(target_space).to eq(test_cell_two)
      end
    end

    context "when there are three cells below" do
      it "drops the cell into the row above [3, 3]" do
        target_row = 3
        target_column = 3

        3.times do
          connect_four.drop_cell(connect_four.create_cell("orange"), target_column)
        end

        test_cell = connect_four.create_cell("blue")
        connect_four.drop_cell(test_cell, target_column)

        game_board = connect_four.instance_variable_get(:@game_board)
        target_space = game_board[target_row - 1][target_column - 1]

        expect(target_space).to eq(test_cell)
      end

      it "drops the cell into the row above [3, 7]" do
        target_row = 3
        target_column = 7

        3.times do
          connect_four.drop_cell(connect_four.create_cell("orange"), target_column)
        end

        test_cell = connect_four.create_cell("blue")
        connect_four.drop_cell(test_cell, target_column)

        game_board = connect_four.instance_variable_get(:@game_board)
        target_space = game_board[target_row - 1][target_column - 1]

        expect(target_space).to eq(test_cell)
      end
    end
  end

  describe "#check_four_horizontal" do
    subject(:connect_four) { described_class.new }

    context "when there are four same-color cells connected" do
      it "returns orange" do
        orange_cell = connect_four.create_cell("orange")
        4.times do |time|
          connect_four.drop_cell(orange_cell, time + 1)
        end

        winning_color = connect_four.check_four_horizontal
        expect(winning_color).to eq("orange")
      end

      it "returns blue" do
        blue_cell = connect_four.create_cell("blue")
        4.times do |time|
          connect_four.drop_cell(blue_cell, time + 4)
        end

        winning_color = connect_four.check_four_horizontal
        expect(winning_color).to eq("blue")
      end
    end

    context "when there are no same-color cells connected" do
      it "returns false" do
        single_cell = connect_four.create_cell("blue")
        connect_four.drop_cell(single_cell, 4)

        single_check = connect_four.check_four_horizontal
        expect(single_check).to be false
      end
    end
  end

  # describe "check_four_vertical" do
  #   subject(:connect_four) { described_class.new }

  #   context "when there are four same-color cells connected" do
  #     it "returns blue"
  #     it "returns orange"
  #   end

  #   context "when there are no same-color cells connected" do
  #     it "returns false"
  #   end
  # end
end
