require 'gosu'
require_relative 'gol.rb'

class GameOfLifeWindow < Gosu::Window

  def initialize(height=800, width=600)

    # Basics
    @height = height
    @width = width
    super height, width, false
    self.caption = 'My Game of Life'

    # Colors
    @white = Gosu::Color.new(0xffededed)
    @black = Gosu::Color.new(0xcc121212)

    # World
    @rows = height/10
    @cols = width/10
    @world = World.new(@rows, @cols)
    @row_height = height/@rows
    @col_width = width/@cols
    @world.randomly_populate

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
    @world.cells.each do |cell|
      if cell.alive?
        draw_quad(cell.x * @col_width, cell.y * @row_height, @black,
                  cell.x * @col_width + @col_width, cell.y * @row_height, @black,
                  cell.x * @col_width + @col_width, cell.y * @row_height + @row_height, @black,
                  cell.x * @col_width, cell.y * @row_height + @row_height, @black)
      end
    end
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
