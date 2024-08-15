require "io/console"
require "rainbow"
require "lolize"
require_relative "lib/cell"
require_relative "lib/display"
require_relative "lib/connect_four"

connect_four = ConnectFour.new
connect_four.play_game
