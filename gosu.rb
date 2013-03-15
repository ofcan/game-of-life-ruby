require 'gosu'
require_relative 'gol.rb'

class GameOfLifeWindow < Gosu::Window

  def initialize(height=300, width=300)

    # Basics
    @height = height
    @width = width
    super height, width, false
    self.caption = 'My Game of Life'

    # Colors
    @white = Gosu::Color.new(0xffededed)
    @black = Gosu::Color.new(0xff121212)

    # Game world
    @rows = height/10
    @cols = width/10
    @world = World.new(@cols, @rows)
    @game = Game.new(@world)
    @row_height = height/@rows
    @col_width = width/@cols
    @game.world.randomly_populate

    @generation = 0
  end

  def update
    unless @game.world.live_cells.count == 0
      @game.tick!
      @generation += 1
    end
  end

  def draw
    draw_background
    @game.world.cells.each do |cell|
      if cell.alive?
        draw_quad(cell.x * @col_width, cell.y * @row_height, @white,
                  cell.x * @col_width + @col_width, cell.y * @row_height, @white,
                  cell.x * @col_width + @col_width, cell.y * @row_height + @row_height, @white,
                  cell.x * @col_width, cell.y * @row_height + @row_height, @white)
      end
    end
  end

  def button_down(id)
    case id
    when Gosu::KbSpace
      @game.world.randomly_populate
    when Gosu::KbEscape
      close
    end
  end

  def needs_cursor?
    true
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
