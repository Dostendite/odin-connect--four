# disk / cell class for the connect four game
class Cell
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def to_s
    if @color == "blue"
      Rainbow("⚫").color("#0A8AF2").bright
    else
      Rainbow("⚫").color("#F2970A").bright
    end
  end
end
