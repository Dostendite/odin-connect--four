# text display module for the connect four game
module Display
  def print_welcome_message
    welcome_message = <<~HEREDOC
      Hello! This is my first TDD Project: Connect Four.

      If you like it you can find me as dostendite on GitHub!

      Press any key to continue... 
    HEREDOC
    print welcome_message
  end
end