require 'rspec'
require_relative 'gol.rb'
  
describe 'Game of life' do

  let!(:world) { World.new }
  let!(:cell) { Cell.new }

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

    it 'Creates a live cell' do
      cell.should be_alive
    end

    it 'Kills a cell' do
      cell.die!
      cell.should be_dead
    end

    it 'Revives a dead cell' do
      cell.die!
      cell.should_not be_alive
      cell.revive!
      cell.should be_alive
    end

#    it 'Cannot create 2 cells on the same spot' do
#      cell_a = Cell.new(world, 1, 1)
#      cell_b = Cell.new(world, 1, 1)
#      cell_c = Cell.new(world, 1, 1)
#      world.cells.count.should == 1
#    end

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

  context 'Rule 1: Any live cell with fewer than two live neighbours dies, as if caused by under-population.' do
    it 'Kills a cell it it has less than 2 neighbours' do
      cell.neighbours.count.should == 0
      neighbour_cell = Cell.new(cell.world, 1, 0)
      cell.world.tick!
      cell.should be_dead
    end

    it 'Doesnt kill a cell if it has 2 neighbours' do
      neighbour_cell_a = Cell.new(cell.world, 1, 0)
      neighbour_cell_b = Cell.new(cell.world, 1, 1)
      cell.world.tick!
      cell.should_not be_dead
    end
  end

  context 'Game' do
    let!(:game) { Game.new }

    it 'should initialize new game' do
      game.rules.should be_empty
      game.world.is_a?(World).should be_true
      game.cells.should be_empty
    end
    
  end

end
