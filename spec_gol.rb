require 'rspec'
require_relative 'gol.rb'

describe 'Game of Life' do
  let!(:game) { Game.new }
  let!(:world) { World.new }
  let!(:cell) { Cell.new }

  context 'Game' do
    subject { Game.new }

    it 'Initializes new game object properly' do
      subject.world.is_a?(World).should be_true
      subject.world.cell_board[1][1].alive.should be_true
    end

    it 'Seeds the world properly' do
      game = Game.new(world, [[0, 1], [1, 1]])
      game.world.cell_board[0][1].alive.should be_true
      game.world.cell_board[1][1].alive.should be_true
    end
  end

  context 'World' do
    subject { World.new }

    it 'Responds to proper methods' do
      subject.should respond_to(:rows)
      subject.should respond_to(:cols)
      subject.should respond_to(:cell_board)
      subject.should respond_to(:cells)
    end

    it 'Cell board initializes properly' do
      subject.cell_board.is_a?(Array).should be_true

      subject.cell_board.each do |row|
        row.is_a?(Array).should be_true
        row.each do |element|
          element.is_a?(Cell).should be_true
          element.alive.should be_false
        end
      end
    end

    it 'Can count cells' do
      subject.cells.count.should == subject.rows * subject.cols
    end

    it 'Can count live cells' do
      subject.live_cells.count.should == 0
      subject.cell_board[1][1].alive = true
      subject.live_cells.count.should == 1
    end

    it 'Detects live neighbour to the north' do
      subject.cell_board[0][1].alive = true
      subject.live_neighbours_around_cell(subject.cell_board[1][1]).count.should == 1
    end
    it 'Detects live neighbour to the north-east' do
      subject.cell_board[0][2].alive = true
      subject.live_neighbours_around_cell(subject.cell_board[1][1]).count.should == 1
    end
    it 'Detects live neighbour to the east' do
      subject.cell_board[1][2].alive = true
      subject.live_neighbours_around_cell(subject.cell_board[1][1]).count.should == 1
    end
    it 'Detects live neighbour to the south-east' do
      subject.cell_board[2][2].alive = true
      subject.live_neighbours_around_cell(subject.cell_board[1][1]).count.should == 1
    end
    it 'Detects live neighbour to the south' do
      subject.cell_board[2][1].alive = true
      subject.live_neighbours_around_cell(subject.cell_board[1][1]).count.should == 1
    end
    it 'Detects live neighbour to the south-west' do
      subject.cell_board[2][0].alive = true
      subject.live_neighbours_around_cell(subject.cell_board[1][1]).count.should == 1
    end
    it 'Detects live neighbour to the west' do
      subject.cell_board[1][0].alive = true
      subject.live_neighbours_around_cell(subject.cell_board[1][1]).count.should == 1
    end
    it 'Detects live neighbour to the north-west' do
      subject.cell_board[0][0].alive = true
      subject.live_neighbours_around_cell(subject.cell_board[1][1]).count.should == 1
    end

    it 'Detects no live neighbours' do
      subject.live_neighbours_around_cell(subject.cell_board[1][1]).should == []
    end

  end

  context 'Cell' do
    subject { Cell.new }

    it 'Initializes new cell object properly' do
      subject.alive.should be_false
    end
  end

  context 'Rules' do

    context 'Rule #1: Any live cell with fewer than two live neighbours dies, as if caused by under-population.' do

      it 'Kills live cell with no neighbours' do
        game.world.cell_board[1][1].should be_alive
        game.tick!
        game.world.cell_board[1][1].should be_dead
      end

      it 'Kills live cell with 1 live neighbour' do
        game = Game.new(world, [[0, 1], [1, 1]])
        game.tick!
        game.world.cell_board[0][1].should be_dead
        game.world.cell_board[1][1].should be_dead
      end

      it 'Doesnt kill live cell with 2 neighbours' do
        game = Game.new(world, [[0, 1], [1, 1], [2, 1]])
        game.tick!
        world.cell_board[0][1].should be_dead
        world.cell_board[1][1].should be_alive
        world.cell_board[2][1].should be_dead
      end

    end

  end

end
