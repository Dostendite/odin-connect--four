# text display module for the connect four game
module Display
  def display_welcome_message
    <<~HEREDOC
      Hello! This is my first TDD Project: Connect Four.

      If you like it you can find me as dostendite on GitHub!

      Press any button to start...
    HEREDOC
  end
end