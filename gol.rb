class Game
  attr_accessor :world, :cells

  def initialize(world=World.new, cells=[])
    @world = world
    @cells = cells
  end

end

class World
  attr_accessor :cells, :rows, :cols, :grid
  
  def initialize(rows=5, cols=5)
    @cells = []
    @grid = Array.new(rows) do
      Array.new(cols)
    end
  end

  def tick!
    cells.each do |cell|
      if cell.neighbours.count < 2
        cell.die!
      end
    end
  end

end
