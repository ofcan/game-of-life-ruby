class Game
  attr_accessor :world

  def initialize(world=World.new)
    @world = world
  end

end

class World
  attr_accessor :rows, :cols, :grid
  
  def initialize(rows=3, cols=3)
    @grid = Array.new(rows) do
      Array.new(cols) do
        Cell.new
      end
    end
  end

end

class Cell
  attr_accessor :alive
  
  def initialize
    @alive = false
  end
end
