require 'rspec'

describe 'game of life' do

  it '1. Any live cell with fewer than two live neighbours dies, as if caused by under-population.' do
    cell = Cell.new
    cell.neighbours_count.should == 0
  end

end
