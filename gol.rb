class Game
  attr_accessor :world

  def initialize(world=World.new, seeds=[[1, 1]])
    @world = world
    seeds.each do |seed|
      world.cell_board[seed[0]][seed[1]].alive = true
    end
  end
  
  def tick!
    next_round_live_cells = []
    next_round_dead_cells = []

    #Rule #1: Any live cell with fewer than two live neighbours dies, as if caused by under-population.
    world.cells.each do |cell|
      if world.live_neighbours_around_cell(cell).count < 2
        next_round_dead_cells << cell
      end
    end

    # Rule #2: Any live cell with two or three live neighbours lives on to the next generation.
    world.cells.each do |cell|
      if cell.alive? && world.live_neighbours_around_cell(cell).count == (2 || 3)
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
        Cell.new(row, col)
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

end

class Cell
  attr_accessor :x, :y, :alive
  
  def initialize(x=0, y=0)
    @x = x
    @y = y
    @alive = false
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
