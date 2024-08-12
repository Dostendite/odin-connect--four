require "rainbow"
require "lolize"
require_relative "lib/cell"
require_relative "lib/connect_four"

# Since this is probably your first experience with TDD, let's extend the
# workflow to include a few more steps:
# 1. Read & understand the requirement for one method only.
# 2. Write one test for that method; run the tests to see it fail.
# 3. Write the method to fulfill the requirement.
# 4. Run the tests again. If they don't all pass, redo steps 1-3.
# 5. When your first test is passing, write the additional tests.
# 6. Run all of the tests. If any do not pass, redo steps 3-5.
# 7. Optional: Refactor your code and/or tests, keeping all tests passing.

connect_four = ConnectFour.new
blue_cell = connect_four.create_cell("blue")
orange_cell = connect_four.create_cell("orange")

4.times do
  connect_four.drop_cell(blue_cell, 2)
end

2.times do
  connect_four.drop_cell(orange_cell, 3)
end

check = connect_four.check_four_vertical
puts "winner is #{check}"

connect_four.print_board
