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
      subject.world.cells[0][0].alive.should be_true
      subject.world.cells[1][1].alive.should be_true
    end
  end

  context 'World' do
    subject { World.new }

    it 'Responds to proper methods' do
      subject.should respond_to(:rows)
      subject.should respond_to(:cols)
      subject.should respond_to(:cells)
    end

    it 'Grid initializes properly' do
      subject.cells.is_a?(Array).should be_true

      subject.cells.each do |row|
        row.is_a?(Array).should be_true
        row.each do |element|
          element.is_a?(Cell).should be_true
          element.alive.should be_false
        end
      end
    end

    it 'Detects neighbour to the north' do
      game.world.cells[0][0].alive_neighbours.count.should == 1
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
    end
  end

end
