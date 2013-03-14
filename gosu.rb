require 'gosu'
require_relative 'gol.rb'

class GameWindow < Gosu::Window

  def initialize
    height = 800
    width = 600
    super height, width, false
    self.caption = 'My Game of Life'
  end

  def update
  end

  def draw
  end

end

window = GameWindow.new
window.show
