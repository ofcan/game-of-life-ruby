class Cell
  attr_accessor :world, :x, :y
  def initialize(world = World.new, x = 0, y = 0)
    @world = world
    @world.cells << self
    @x = x
    @y = y
  end

  def neighbours
    @neighbours = []
    world.cells.each do |cell|
      # Detects neighbour to the north
      if self.x == cell.x && self.y == cell.y - 1
        @neighbours << cell
      end
      # Detects neighbour to the north-east
      if self.x == cell.x - 1 && self.y == cell.y - 1
        @neighbours << cell
      end
      # Detects neighbour to the east
      if self.x == cell.x - 1 && self.y == cell.y
        @neighbours << cell
      end
      # Detects neighbour to the south-east
      if self.x == cell.x - 1 && self.y == cell.y + 1
        @neighbours << cell
      end
      # Detects neighbour to the south
      if self.x == cell.x && self.y == cell.y + 1
        @neighbours << cell
      end
      # Detects neighbour to the south-west
      if self.x == cell.x + 1 && self.y == cell.y + 1
        @neighbours << cell
      end
      # Detects neighbour to the west
      if self.x == cell.x + 1 && self.y == cell.y
        @neighbours << cell
      end
      # Detects neighbour to the north-west
      if self.x == cell.x + 1 && self.y == cell.y - 1
        @neighbours << cell
      end
    end
    @neighbours
  end

  def alive?
    world.cells.include?(self)
  end

  def dead?
    !world.cells.include?(self)
  end

  def revive!
    world.cells.push(self)
  end

  def die!
    world.cells.delete(self)
  end
end

class World
  attr_accessor :cells
  
  def initialize
    @cells = []
  end

  def tick!
    cells.each do |cell|
      if cell.neighbours.count < 2
        cell.die!
      end
    end
  end

end
