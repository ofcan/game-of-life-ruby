require 'rspec'
require_relative 'gol.rb'
  
describe 'game of life' do

  context 'Cell utility methods' do
    it 'spawn new cell at coordinates' do
      cell = Cell.new(3, 5)
      cell.is_a?(Cell).should be_true
      cell.x.should == 3
      cell.y.should == 5
    end
  end

  it '1. Any live cell with fewer than two live neighbours dies, as if caused by under-population.' do
    cell = Cell.new
    cell.neighbours.count.should == 0
  end

end
