class Game
  attr_accessor :world

  def initialize(world=World.new, seeds=[[0, 0], [1, 1]])
    @world = world
    seeds.each do |seed|
      @world.cells[seed[0]][seed[1]].alive = true
    end
  end

end

class World
  attr_accessor :rows, :cols, :cells
  
  def initialize(rows=3, cols=3)
    @cells = Array.new(rows) do |row|
      Array.new(cols) do |col|
        Cell.new(row, col)
      end
    end
  end

end

class Cell
  attr_accessor :alive, :x, :y
  
  def initialize(x=0, y=0)
    @alive = false
    @x = x
    @y = y
  end
end
