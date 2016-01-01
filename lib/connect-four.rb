# Command Line Connect Four implemented in Ruby

class Game
  def start
    puts 'Welcome to Command Line Connect Four'
    print "Please enter player one's (X's) name: "
    p1 = Player.new(gets.chomp,1)
    print "Please enter player two's (O's) name: "
    p2 = Player.new(gets.chomp,2)
    grid = Grid.new
    grid.draw
    
    42.times do |t|
      if t % 2 == 0
        grid.update(p1.id, prompt(p1))
      else
        grid.update(p2.id, prompt(p2))
      end
      grid.draw
      (finish(p1); break) if p1.win?(grid.cells)
      (finish(p2); break) if p2.win?(grid.cells)
      finish if t == 41
    end
  end

  def prompt(player)
    print "#{player.name}'s turn: "
    until (1..7) === (column = gets.to_i)
      puts "Invalid move, try again."
      print "#{player.name}'s turn: "
    end
    return (column - 1)
  end

  def finish(player = nil)
    unless player
      puts "Tie! No one has won."
    else
      puts "#{player.name} has won!"
    end
  end
end

class Player
  attr_reader :name, :id
  def initialize(name, id)
    @name = name
    @id = id
  end

  def win?(cells)
    cells.each_with_index do |col,x|
      col.each_with_index do |cell,y|
        if cell == @id

          # check for horizontal win
          # use #fetch so out-of-bounds index returns nil instead of raising exception
          if cells.fetch(x+1,[])[y] == @id || cells.fetch(x-1,[])[y] == @id
            count = 1
            (1..3).each do |i|
              cells[x+i][y] == @id ? count += 1 : break
            end
            (1..3).each do |i|
              cells.fetch(x-i,[])[y] == @id ? count += 1 : break
            end
            return true if count == 4
          end

          # check for vertical win
          if cells[x][y+1] == @id || cells[x][y-1] == @id
            count = 1
            (1..3).each do |i|
              cells[x][y+i] == @id ? count += 1 : break
            end
            (1..3).each do |i|
              cells[x][y-i] == @id ? count += 1 : break
            end
            return true if count == 4
          end

          # check for diagonal win (positive slope)
          if cells.fetch(x+1,[])[y+1] == @id || cells.fetch(x-1,[])[y-1] == @id
            count = 1
            (1..3).each do |i|
              cells.fetch(x+i,[])[y+i] == @id ? count += 1 : break
            end
            (1..3).each do |i|
              cells.fetch(x-i,[])[y-i] == @id ? count += 1 : break
            end
            return true if count == 4
          end

          # check for diagonal win (negative slope)
          if cells.fetch(x+1,[])[y-1] == @id || cells.fetch(x-1,[])[y+1] == @id
            count = 1
            (1..3).each do |i|
              cells.fetch(x+i,[])[y-i] == @id ? count += 1 : break
            end
            (1..3).each do |i|
              cells.fetch(x-i,[])[y+i] == @id ? count += 1 : break
            end
            return true if count == 4
          end
        end
      end
    end
    return false
  end
end

class Grid
  attr_reader :cells
  def initialize
    @cells = (0..6).map { [0,0,0, 0,0,0] }
  end

  def update(player, column)
    if @cells[column].include?(0)
      @cells[column][ @cells[column].index(0) ] = player
    else
      return nil
    end
  end

  def draw
    puts ''
    (0..5).reverse_each do |i|
      @cells.each do |j|
        if j[i] != 0
          j[i] == 1 ? (print "| X ") : (print "| O ")
        else
          print '|   '
        end
      end
      print '|'
      puts "\n+---+---+---+---+---+---+---+"
    end
    puts     "  1   2   3   4   5   6   7\n\n"
  end
end


Game.new.start