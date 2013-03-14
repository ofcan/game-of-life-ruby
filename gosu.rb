require 'gosu'
require_relative 'gol.rb'

class GameWindow < Gosu::Window

  def initialize
    super 800, 600, false
    self.caption = 'My Game of Life'
  end

  def update
  end

  def draw
  end

end

window = GameWindow.new
window.show
