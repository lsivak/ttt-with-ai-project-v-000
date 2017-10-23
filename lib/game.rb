require 'pry'
class Game
  Players::Human
  attr_accessor :board, :player_1, :player_2, :cells

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
  ]


  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board

  end

  def current_player
    current_player = player_1
    if @board.turn_count % 2 == 0
      player_1
    elsif @board.turn_count % 2 == 1
      player_2
    end
  end

  def over?
    won? || draw?

  end
  def draw?
    if @board.full? && !won?
      true
    end
  end
  def won?
    WIN_COMBINATIONS.detect do |win|
      @board.cells[win[0]] == "X" && @board.cells[win[1]] == "X" && @board.cells[win[2]] == "X"  && @board.taken?(win[0]+1)||
      @board.cells[win[0]] == "O" && @board.cells[win[1]] == "O" && @board.cells[win[2]] == "O" && @board.taken?(win[0]+1)
    end
  end

  def winner
    won? ? @board.cells[won?[0]] : nil
  end

  def turn
    player_1 = current_player
    input = player_1.move(@board)
    if @board.valid_move?(input)
      @board.update(input, current_player)

      player_2 = current_player
    else
      turn

    end
  end


  def play
    while !over?
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
end
