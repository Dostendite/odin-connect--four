require_relative "cell"
require_relative "display"

# game class for the connect four game
class ConnectFour
  include Display

  def initialize
    @game_board = create_board
    @game_over = false
    @moves_played = 0
    @current_cell = nil
    @winning_color = nil
  end

  def print_board
    clear_screen
    @game_board.each do |row|
      row.each do |element|
        print Rainbow("●").white if element.nil?
        if element.instance_of?(Cell)
          print element
        end
        print " "
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

  def play_game
    display_introduction
    prompt_starting_color

    loop do
      print_board
      drop_column = prompt_drop_column
      play_turn(@current_cell, drop_column)
      break if game_over?

      @current_cell = swap_cells
    end

    display_final_message
  end

  def game_over?
    @winning_color = check_four_victory
    return false if @winning_color == false

    @game_over = true
  end

  def display_final_message
    announce_winner
    clear_screen

    if @winning_color == "tie"
      print_final_message_tie
      return
    end
    print_final_message(@current_cell) if @winning_color
  end

  def display_introduction
    clear_screen
    print_welcome_message
    puts
    $stdin.getch
    clear_screen
  end

  def swap_cells
    if @current_cell == "blue"
      "orange"
    else
      "blue"
    end
  end

  def prompt_drop_column
    print "Enter column to drop your "
    if @current_cell == "blue"
      print Rainbow("●").color("#0A8AF2").bright
    else
      print Rainbow("●").color("#F2970A").bright
    end
    print " piece [1-7]"
    puts
    ask_column_choice
  end

  def prompt_starting_color
    blue_cell = create_cell("blue")
    orange_cell = create_cell("orange")
    puts "Choose starting cell color"
    puts "Blue -> #{blue_cell} || Orange -> #{orange_cell}\n"
    puts
    @current_cell = ask_starting_color
    clear_screen
  end

  def play_turn(cell_color, column)
    next_cell = create_cell(cell_color)
    drop_cell(next_cell, column)
    @moves_played += 1
  end

  def drop_cell(cell, column)
    base_row = 5
    loop do
      if @game_board[base_row][column - 1].nil?
        @game_board[base_row][column - 1] = cell
        break
      else
        base_row -= 1
      end
    end
  end

  def full_column?(column)
    @game_board.each_index do |row|
      return false if @game_board[row][column].nil?
    end
    true
  end

  def check_four_victory
    return "tie" if @moves_played == 42

    checks = []
    checks << check_four_horizontal
    checks << check_four_vertical
    checks << check_four_diagonal

    checks.each do |check|
      return check if check
    end
    false
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
      next if row.all?(&:nil?) || row_idx > 2

      row.each_with_index do |element, column_idx|
        next unless element.instance_of?(Cell)
        
        current_color = element.color
        cells_below = [@game_board[row_idx + 1][column_idx],
                       @game_board[row_idx + 2][column_idx],
                       @game_board[row_idx + 3][column_idx]]

        return current_color if cells_below.all? { |cell| cell.color == current_color }
  
      # Old Algorithm (Find out why it didn't work)
      #   puts "Scanning cell #{element} at #{row_idx}, #{column_idx} | score -> #{score}"
      #   loop do
      #     row_idx += 1
      #     break if row_idx > 3 && score < 2

      #     return current_color if score == 4
      #     puts "Color below -> #{@game_board[row_idx][column_idx]}"
      #     break unless @game_board[row_idx][column_idx].color == current_color

      #     score += 1
      #   end
      end
    end
    false
  end

  def check_four_diagonal
    @game_board.each_with_index do |row, row_idx|
      next if row.all?(&:nil?)

      row.each_with_index do |element, column_idx|
        next unless element.instance_of?(Cell)

        left_check = four_diagonal_left?(element.color, row_idx, column_idx)
        right_check = four_diagonal_right?(element.color, row_idx, column_idx)
        return element.color if left_check || right_check
      end
    end
    false
  end

  def out_of_bounds?(row, column)
    (row > 5 || column > 6) || (row.negative? || column.negative?)
  end

  private

  def announce_winner
    clear_screen
    print_board
    if @winning_color == "tie"
      puts "The game was a tie!"
    else
      puts "#{@winning_color} wins!".capitalize
    end
    sleep(2.5)
  end

  def clear_screen
    print `clear`
  end

  def ask_column_choice
    loop do
      column_choice = gets.strip.to_i

      if full_column?(column_choice - 1)
        puts "Column is full! Enter a number from 1 to 7"
        next
      end

      return column_choice if (1..7).include?(column_choice)

      puts "Wrong input! Please enter a number from 1 to 7"
    end
  end

  def ask_starting_color
    loop do
      color_choice = gets.strip.downcase
      return "blue" if color_choice[0] == "b"
      return "orange" if color_choice[0] == "o"

      puts "Wrong input! Please enter 'blue' or 'orange'"
    end
  end

  def four_diagonal_left?(current_color, row, column)
    score = 1
    loop do
      return true if score == 4

      row += 1
      column -= 1
      break if out_of_bounds?(row, column)
      break if @game_board[row][column].nil?
      break if @game_board[row][column].color != current_color

      score += 1
    end
    false
  end

  def four_diagonal_right?(current_color, row, column)
    score = 1
    loop do
      return true if score == 4

      row += 1
      column += 1
      break if out_of_bounds?(row, column)
      break if @game_board[row][column].nil?
      break if @game_board[row][column].color != current_color

      score += 1
    end
    false
  end
end

# when winner connects four, the connected four BECOME A RAINBOW
# after that animation, let the player decide if they want to restart

# def cololize(string)
#   colorizer = Lolize::Colorizer.new
#   100.times do
#     system "clear"
#     puts colorizer.write(string)
#     sleep(0.05)
#   end
# end
