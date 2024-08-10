require_relative "cell"

# game class for the connect four game
class ConnectFour
  def initialize
    @game_board = create_board
  end

  def print_board
    @game_board.each do |row|
      row.each do |element|
        print Rainbow("⚫") if element.nil?
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
    puts Rainbow("1 2 3 4 5 6 7\n").gray
  end

  def create_board
    Array.new(6) { Array.new(7) }
  end

  def create_cell(color = "orange")
    Cell.new(color)
  end
end

# board -> white

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
