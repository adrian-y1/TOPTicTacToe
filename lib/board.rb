# Class that creates the board
# Checks for a winner? and if the board is full?
# Also displays the board
class Board
  attr_accessor :board

  def initialize(player_x, player_o)
    @board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @winning_combos = [[0, 1, 2], # Horizontal (Across)
                       [3, 4, 5], # Horizontal (Across)
                       [6, 7, 8], # Horizontal (Across)

                       [0, 3, 6], # Vertical (Top-Down)
                       [1, 4, 7], # Vertical (Top-Down)
                       [2, 5, 8], # Vertical (Top-Down)

                       [0, 4, 8], # Diagonal
                       [2, 4, 6]] # Diagonal
    @player_x = player_x
    @player_o = player_o
  end

  # Checks if a player has won the game
  def winner?
    b = @board
    @winning_combos.each do |combo|
      if b[combo[0]] == @player_x && b[combo[1]] == @player_x && b[combo[2]] == @player_x
        puts "Player #{@player_x} has won the game!"
        return true
      elsif b[combo[0]] == @player_o && b[combo[1]] == @player_o && b[combo[2]] == @player_o
        puts "Player #{@player_o} has won the game!"
        return true
      end
    end
    false
  end

  # Checks if the board is full or not
  def full?
    @board.all? { |n| !n.is_a?(Integer) }
  end

  def display
    puts "-------------"
    puts "| #{@board[0]} | #{@board[1]} | #{@board[2]} |"
    puts "----+----+---"
    puts "| #{@board[3]} | #{@board[4]} | #{@board[5]} |"
    puts "----+----+---"
    puts "| #{@board[6]} | #{@board[7]} | #{@board[8]} |"
    puts "-------------"
  end

  def free?(position)
    @board[position - 1].is_a?(Integer)
  end

  # Sets the player on the board
  def place_marker(player, position)
    @board[position - 1] = player
  end
end