# frozen_string_literal: true

require_relative 'board'

# Class that creates the players along with the methods required to play the game
class Player
  def initialize(board = Board.new('X', 'O'))
    @player_x = 'X'
    @player_o = 'O'
    @current_player = @player_x
    @board = board
  end

  # After the current player has played their turn
  # the play is passed on to the other player
  def take_turns
    @board.display
    loop do
      if @current_player == @player_x
        play(@player_x)
        @current_player = @player_o
      elsif @current_player == @player_o
        play(@player_o)
        @current_player = @player_x
      end
      @board.display
      return if @board.winner? || @board.full?
    end
  end

  # Gets and sets the player's position and displays the board
  def play(player)
    get_position(player)
    @board.place_marker(player, @position)
  end

  # Gets the player's position and verifies it
  def get_position(player)
    loop do
      puts "Player #{player} choose your position number (1-9)"
      user_input = gets.chomp.to_i
      @position = verify_position(user_input)
      return @position if @position
      
      puts 'Input Error! Please enter a position number between 1 and 9.'
    end
  end

  private

  # Checks if the position given is between 1-9 and its free?
  def verify_position(position)
    if position.between?(1, 9)
      if @board.free?(position)
        return position
      end
    end
  end
end
