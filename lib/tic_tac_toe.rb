class TicTacToe
  def initialize(board = nil)
    @board = board || [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 4, 8],
  [2, 4, 6],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(index, current_player)
    @board[index] = current_player
  end

  def position_taken?(location)
    @board[location] != " " && @board[location] != ""
  end

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      turn
    end
  end

  def turn_count
    counter = 0
    @board.each do |index|
      if index == "X" || index == "O"
        counter += 1
      end
    end
    counter
  end

  def current_player
    if turn_count % 2 == 0
      return "X"
    else
      return "O"
    end
  end

  def won?
    empty_board = @board.all? do |space|
      space == " "
    end
    if empty_board
      return false
    end
    WIN_COMBINATIONS.each do |array|
      all_taken = position_taken?(array[0]) && position_taken?(array[1]) && position_taken?(array[2])
      if all_taken && @board[array[0]] == @board[array[1]] && @board[array[0]] == @board[array[2]]
        return array
      end
    end
    false
  end

  def full?
    full_board = @board.all? do |character|
      character == "X" || character == "O"
    end
  end

  def draw?
    if won?
      return false
    end
    if full?
      return true
    end
    false
  end

  def over?
    if won?
      return true
    end
    if draw?
      return true
    end
    false
  end

 def winner
   array = won?
   if array
     return @board[array[0]]
   end
 end

 def play
   until over?
     turn
   end
   if won?
     token = winner
     puts "Congratulations #{token}!"
   else draw?
     puts "Cat's Game!"
   end
 end
end
