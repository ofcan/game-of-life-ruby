class Game
  attr_accessor :world

  def initialize(world=World.new, seeds=[])
    @world = world
    seeds.each do |seed|
      world.cell_board[seed[0]][seed[1]].alive = true
    end
  end
  
  def tick!
    next_round_live_cells = []
    next_round_dead_cells = []

#    To see your progress while optimising...
#
#    @world.cells.each_with_index do |cell, index|
#      puts "#{index} out of #{@world.cells.size}"
#    end

    @world.cells.each do |cell|
      neighbour_count = world.live_neighbours_around_cell(cell).count
      # Rule 1: 
      # Any live cell with fewer than two live neighbours dies
      if cell.alive? && neighbour_count < 2
        next_round_dead_cells << cell
      end
      # Rule 2:
      # Any live cell with two or three live neighbours lives on to the next generation
      if cell.alive? && neighbour_count == (2 || 3)
        next_round_live_cells << cell
      end
      # Rule 3:
      # Any live cell with more than three live neighbours dies
      if cell.alive? && neighbour_count > 3
        next_round_dead_cells << cell
      end
      # Rule 4:
      # Any dead cell with exactly three live neighbours becomes a live cell
      if cell.dead? && neighbour_count == 3
        next_round_live_cells << cell
      end
    end

    next_round_live_cells.each do |cell|
      cell.revive!
    end
    next_round_dead_cells.each do |cell|
      cell.die!
    end
  end
end

class World
  attr_accessor :rows, :cols, :cell_board, :cells
  
  # Scheme of default initialized world matrix
  #------------------------
  #     0     1     2
  # 0 [ dead, dead, dead ]
  # 1 [ dead, alive, dead ]
  # 2 [ dead, dead, dead ]
  #-----------------------

  def initialize(rows=3, cols=3)
    @rows = rows
    @cols = cols
    @cells = []

    @cell_board = Array.new(rows) do |row|
      Array.new(cols) do |col|
        Cell.new(col, row) # Note col is 1st
      end
    end

    cell_board.each do |row|
      row.each do |element|
        if element.is_a?(Cell)
          cells << element
        end
      end
    end
  end

  def live_cells
    cells.select { |cell| cell.alive }
  end

  def dead_cells
    cells.select { |cell| cell.alive == false }
  end

  def live_neighbours_around_cell(cell)
    live_neighbours = []
    live_cells.each do |live_cell|
      # Neighbour to the North
      if live_cell.x == cell.x - 1 && live_cell.y == cell.y
        live_neighbours << live_cell
      end
      # Neighbour to the North-East
      if live_cell.x == cell.x - 1 && live_cell.y == cell.y + 1
        live_neighbours << live_cell
      end
      # Neighbour to the East
      if live_cell.x == cell.x && live_cell.y == cell.y + 1
        live_neighbours << live_cell
      end
      # Neighbour to the South-East
      if live_cell.x == cell.x + 1 && live_cell.y == cell.y + 1
        live_neighbours << live_cell
      end
      # Neighbour to the South
      if live_cell.x == cell.x + 1 && live_cell.y == cell.y
        live_neighbours << live_cell
      end
      # Neighbour to the South-West
      if live_cell.x == cell.x + 1 && live_cell.y == cell.y - 1
        live_neighbours << live_cell
      end
      # Neighbour to the West
      if live_cell.x == cell.x && live_cell.y == cell.y - 1
        live_neighbours << live_cell
      end
      # Neighbour to the North-West
      if live_cell.x == cell.x - 1 && live_cell.y == cell.y - 1
        live_neighbours << live_cell
      end
    end
    live_neighbours
  end

  def randomly_populate
    cells.each do |cell|
      cell.alive = [true, false].sample
    end
  end

end

class Cell
  attr_accessor :x, :y, :alive #, :height, :width
  
  def initialize(x=0, y=0)
    @x = x
    @y = y
    @alive = false

    # Gosu
    # @height = height
    # @width = width
  end

  def alive?
    alive
  end

  def dead?
    !alive
  end

  def die!
    @alive = false
  end

  def revive!
    @alive = true # same as > self.alive = true
  end
end
