require 'spec_helper'
require 'advent_02'

describe 'DepthCalculator' do
  let(:puzzle_input) do
    File.readlines('./spec/fixtures/advent-02.txt')
  end

  it 'calculates the product' do
    dc = DepthCalculator.new(puzzle_input)
    dc.process

    expect(dc.product).to be(185_581_4)
  end
end

describe 'AimCalculator' do
  let(:puzzle_input) do
    File.readlines('./spec/fixtures/advent-02.txt')
  end

  it 'calculates the product from sample' do
    sample_input = [
      'forward 5',
      'down 5',
      'forward 8',
      'up 3',
      'down 8',
      'forward 2',
    ]

    dc = AimCalculator.new(sample_input)
    dc.process

    expect(dc.product).to be(900)
  end

  it 'calculates the product' do
    dc = AimCalculator.new(puzzle_input)
    dc.process

    expect(dc.product).to be(184_545_571_4)
  end
end
