class Cell

  attr_accessor :world, :x, :y

  def initialize(world=World.new, x=0, y=0)
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

    end
    @neighbours
  end

end

class World
  attr_accessor :cells

  def initialize
    @cells = []
  end
  
end
