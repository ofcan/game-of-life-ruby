require 'rspec'
require_relative 'gol.rb'
  
describe 'Game of life' do

  context 'Cell' do
    subject { Cell.new }

    it 'Creates new cell properly' do
      subject.x = 3
      subject.y = 5
      subject.is_a?(Cell).should be_true
      subject.world.is_a?(World).should be_true
      subject.x.should == 3
      subject.y.should == 5
      subject.world.cells.count.should == 1
    end

    it 'Detects cell to the north' do
      neighbour_cell = Cell.new(subject.world, 0, 1)
      subject.neighbours.count.should == 1
    end

    it 'Detects cell to the north-east' do
      neighbour_cell = Cell.new(subject.world, 1, 1)
      subject.neighbours.count.should == 1
    end

    it 'Detects cell to the east' do
      neighbour_cell = Cell.new(subject.world, 1, 0)
      subject.neighbours.count.should == 1
    end

    it 'Detects cell to the south-east' do
      neighbour_cell = Cell.new(subject.world, 1, -1)
      subject.neighbours.count.should == 1
    end

    it 'Detects cell to the south' do
      neighbour_cell = Cell.new(subject.world, 0, -1)
      subject.neighbours.count.should == 1
    end

    it 'Detects cell to the south-west' do
      neighbour_cell = Cell.new(subject.world, -1, -1)
      subject.neighbours.count.should == 1
    end

    it 'Detects cell to the west' do
      neighbour_cell = Cell.new(subject.world, -1, 0)
      subject.neighbours.count.should == 1
    end

    it 'Detects cell to the north-west' do
      neighbour_cell = Cell.new(subject.world, -1, 1)
      subject.neighbours.count.should == 1
    end

  end

  context 'World' do
    subject { World.new }

    it 'Has empty cells array upon initialization' do
      subject.cells.count.should == 0
    end

    it 'Properly adds cells to world' do
      cell_a = Cell.new(subject)
      cell_b = Cell.new(subject)
      cell_c = Cell.new(subject)
      subject.cells.count.should == 3
    end
  end

  context 'Rules' do
    it '1. Any live cell with fewer than two live neighbours dies, as if caused by under-population.' do
      cell = Cell.new
      cell.neighbours.count.should == 0
    end
  end

end
