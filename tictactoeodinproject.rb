class Board
  def initialize
    @board = Array.new(3) { Array.new(3, " ") }
  end

  def display_board
    puts "-------------"
    @board.each do |row|
      puts "| #{row.join(" | ")} |"
      puts "-------------"
    end
  end

  def update_board(row, col, symbol)
    if @board[row][col] == " "
      @board[row][col] = symbol
      true
    else
      false
    end
  end

  def winner?
    winning_combinations = [
      [@board[0][0], @board[0][1], @board[0][2]],
      [@board[1][0], @board[1][1], @board[1][2]],
      [@board[2][0], @board[2][1], @board[2][2]],
      [@board[0][0], @board[1][0], @board[2][0]],
      [@board[0][1], @board[1][1], @board[2][1]],
      [@board[0][2], @board[1][2], @board[2][2]],
      [@board[0][0], @board[1][1], @board[2][2]],
      [@board[2][0], @board[1][1], @board[0][2]]
    ]
    winning_combinations.any? do |combination|
      combination.uniq.size == 1 && combination.first != " "
    end
  end

  def full?
    @board.all? { |row| row.none?(" ") }
  end
end

class Player
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end

class Game
  def initialize
    @board = Board.new
    @player1 = Player.new("Player 1", "X")
    @player2 = Player.new("Player 2", "O")
    @current_player = @player1
  end

  def play
    until @board.full? || @board.winner?
      system "clear" or system "cls"
      @board.display_board
      take_turn
      break if @board.winner?
      switch_player
    end
    system "clear" or system "cls"
    @board.display_board
    if @board.winner?
      puts "#{@current_player.name} wins!"
    else
      puts "It's a draw!"
    end
  end

  private

  def take_turn
    row, col = -1, -1
    until row.between?(0,2) && col.between?(0,2) && @board.update_board(row, col, @current_player.symbol)
      puts "#{@current_player.name}, enter row (0, 1, 2): "
      row = gets.chomp.to_i
      puts "Enter column (0, 1, 2): "
      col = gets.chomp.to_i
    end
  end

  def switch_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end
end

# To play, paste everything above into IRB, then create a new game instance and start it:
# game = Game.new
# game.play
