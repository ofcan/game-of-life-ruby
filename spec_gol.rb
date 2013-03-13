require 'rspec'
require_relative 'gol.rb'

describe 'Game of Life' do
  let!(:game) { Game.new }
  let(:world) { World.new }

  context 'Game' do
    subject { Game.new }

    it 'Creates new game object' do
      subject.world.is_a?(World).should be_true
      subject.cells.should be_empty
    end
  end
    

  context 'World' do
    subject { World.new }
    it 'Creates new world object' do
      subject.is_a?(World).should be_true
      subject.cells.should be_empty
      subject.should respond_to(:rows)
      subject.should respond_to(:cols)
      subject.should respond_to(:grid)
    end
  end

end
