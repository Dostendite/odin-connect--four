require "pry-byebug"
require_relative "cell"

# game class for the connect four game
class ConnectFour
  def initialize
    @game_board = create_board
    @moves_played = 0
  end

  def print_board
    @game_board.each do |row|
      row.each do |element|
        print Rainbow("⚫").white if element.nil?
        if element.instance_of?(Cell)
          if element.color == "blue"
            print Rainbow("⚫").color("#0A8AF2").bright
          else
            print Rainbow("⚫").color("#F2970A").bright
          end
        end
      end
      puts
    end
    puts Rainbow("1 2 3 4 5 6 7").gray
    puts "-------------\n"
  end

  def create_board
    Array.new(6) { Array.new(7) }
  end

  def create_cell(color = "orange")
    Cell.new(color)
  end

  def play_game
    # give introduction (Colored HEREDOC?)
    # ask for starting color (blue or orange)
    # print board
    # start game loop:
    # -> check for 4-connections after each move and announce them
    #   -> e.g.: if blue wins; "Blue is the winner!"
    # -> ask player 1 for target column
    # -> validate it, drop the cell, set as last move & add 1 to moves
    # -> same for player 2 ^
  end

  def play_turn(cell, column)
    # get user input for column
    drop_cell(cell, column)
    @moves_played += 1
  end

  def drop_cell(cell, column)
    # out of bounds check is done
    # before this method is ever called
    base_row = 5
    column -= 1
    loop do
      if @game_board[base_row][column].nil?
        @game_board[base_row][column] = cell
        break
      else
        base_row -= 1
      end
    end
  end

  def check_four_horizontal
    @game_board.each do |row|
      next if row.all?(&:nil?)
      next unless row[3].instance_of?(Cell)

      current_color = row[3].color

      if row[..3].all? { |el| el.instance_of?(Cell) }
        left_color_check = row[0..3].all? { |cell| cell.color == current_color }
        return current_color if left_color_check
      end

      if row[3..].all? { |el| el.instance_of?(Cell) }
        left_color_check = row[3..].all? { |cell| cell.color == current_color }
        return current_color if left_color_check
      end
    end
    false
  end

  def check_four_vertical
    @game_board.each_with_index do |row, row_idx|
      next if row.all?(&:nil?)

      row.each_with_index do |element, column|
        next unless element.instance_of?(Cell)

        current_color = element.color
        score = 1
        loop do
          row_idx += 1
          break if row_idx > 3 && score < 2
          return current_color if score == 4
          break unless @game_board[row_idx][column].color == current_color

          score += 1
        end
      end
    end
    false
  end

  def out_of_bounds?(row, column)
    row -= 1
    column -= 1
    (row > 5 || column > 6) || (row < 1 || column < 1)
  end
end

# when winner connects four, the connected four BECOME A RAINBOW
# after that, let the player decide if they want to restart

# def cololize(string)
#   colorizer = Lolize::Colorizer.new
#   100.times do
#     system "clear"
#     puts colorizer.write(string)
#     sleep(0.05)
#   end
# end
