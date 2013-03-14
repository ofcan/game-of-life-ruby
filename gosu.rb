require 'gosu'
require_relative 'gol.rb'

class GameOfLifeWindow < Gosu::Window

  def initialize(height=800, width=600)
    @height = height
    @width = width

    super height, width, false
    self.caption = 'My Game of Life'

    # Colors
    @white = Gosu::Color.new(0xffededed)
    @black = Gosu::Color.new(0xcc121212)

    @world = World.new(height/10, width/10)

#    @generation = 0
  end

  def update
#    unless @world.live_cells.count == 0
#      @world.tick!
#      @generation += 1
#    end
  end

  def draw
    draw_background
  end

  def draw_background
    draw_quad(0, 0, @white,
              width, 0, @white,
              width, height, @white,
              0, height, @white)
  end

end

window = GameOfLifeWindow.new
window.show
