require_relative "cell"

# game class for the connect four game
class ConnectFour
  def initialize
    @game_board = create_board
    @moves_played = 0
    @last_move = nil
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
    # print board
    # start game loop:
    # -> check for winning combinations or a tie
    # -> ask player 1 for target column
    # -> validate it, drop the cell, set as last move & add 1 to moves
    # - >same for player 2 ^
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

  # def check_connections
  # end

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
