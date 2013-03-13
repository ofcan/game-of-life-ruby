class Game
  attr_accessor :world

  def initialize(world=World.new, seeds=[[1, 1]])
    @world = world
    seeds.each do |seed|
      @world.cell_board[seed[0]][seed[1]].alive = true
    end
  end

end

class World
  attr_accessor :rows, :cols, :cell_board, :cells
  
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
          @cells << element
        end
      end
    end
  end

  def live_cells
    cells.select { |cell| cell.alive }
  end

  def neighbours_around_cell(cell)
    @neighbours = []
    live_cells.each do |live_cell|
      # Neighbour to the North
      if live_cell.x == cell.x - 1 && live_cell.y == cell.y
        @neighbours << cell
      end
      # Neighbour to the North-East
      if live_cell.x == cell.x - 1 && live_cell.y == cell.y + 1
        @neighbours << cell
      end
      # Neighbour to the East
      if live_cell.x == cell.x && live_cell.y == cell.y + 1
        @neighbours << cell
      end
      # Neighbour to the South-East
      if live_cell.x == cell.x + 1 && live_cell.y == cell.y + 1
        @neighbours << cell
      end
      # Neighbour to the South
      if live_cell.x == cell.x + 1 && live_cell.y == cell.y
        @neighbours << cell
      end
      # Neighbour to the South-West
      if live_cell.x == cell.x + 1 && live_cell.y == cell.y - 1
        @neighbours << cell
      end
      # Neighbour to the West
      if live_cell.x == cell.x && live_cell.y == cell.y - 1
        @neighbours << cell
      end
      # Neighbour to the North-West
      if live_cell.x == cell.x - 1 && live_cell.y == cell.y - 1
        @neighbours << cell
      end
    end
    @neighbours
  end

end

class Cell
  attr_accessor :x, :y, :alive
  
  def initialize(x=0, y=0)
    @x = x
    @y = y
    @alive = false
  end
end
