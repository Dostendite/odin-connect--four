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

  def print_final_message(color)
    final_message = <<~HEREDOC
      It looks like the #{color} cells won this time!

      Thank you for playing <3

      if you want to restart... You can reload with F5 >:3
    HEREDOC
    print final_message
  end
end
