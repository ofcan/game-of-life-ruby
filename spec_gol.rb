require 'rspec'
require_relative 'gol.rb'

describe 'Game of Life' do
  let!(:cell) { Cell.new }
  let(:world) { World.new }
  
  context 'Cell' do
    subject { Cell.new }
    it 'Creates new cell object' do
      subject.is_a?(Cell).should be_true
      subject.world.is_a?(World).should be_true
      subject.x.should == 0
      subject.y.should == 0
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

    it 'Kills a cell' do
      cell.die!
      cell.should be_dead
    end

    it 'New cell is alive' do
      cell.should be_alive
    end

    it 'Revives a dead cell' do
      cell.die!
      cell.revive!
      cell.should be_alive
    end

  end

  context 'World' do
    subject { World.new }
    it 'Creates new world object' do
      subject.is_a?(World).should be_true
      subject.cells.should be_empty
    end
  end

  context 'Rules' do

    context 'Rule #1: Any live cell with fewer than two live neighbours dies, as if caused by under-population.' do
      it 'Kill a cell with < 2 neighbours' do
        neighbour_cell = Cell.new(cell.world, 0, 1)
        cell.world.tick!
        cell.should be_dead
      end
    end

  end

end
