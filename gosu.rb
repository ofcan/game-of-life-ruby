require 'gosu'
require_relative 'gol.rb'

class GameOfLifeWindow < Gosu::Window

  def initialize
    height = 800
    width = 600
    super height, width, false
    self.caption = 'My Game of Life'

    # Colors
    @white = Gosu::Color.new(0xedededed)
    @black = Gosu::Color.new(0x34343434)

    @world = World.new(height/10, width/10)

    @generation = 0
  end

  def update
    unless @world.live_cells == []
      @world.tick!
      @generation += 1
    end
  end

  def draw
    draw_background
    draw_quad(100, 100, @white,
              200, 100, @white,
              200, 200, @white,
              100, 200, @white)
  end

  def draw_background
    draw_quad(0, 0, @black,
              width, 0, @black,
              width, height, @black,
              0, height, @black)
  end

end

window = GameOfLifeWindow.new
window.show
