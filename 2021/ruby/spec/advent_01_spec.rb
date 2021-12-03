require 'spec_helper'
require 'advent_01'

describe 'DepthCounter' do
  let(:puzzle_input) do
    File.readlines('./spec/fixtures/advent-01.txt').map(&:to_i)
  end

  it 'counts the number of increased measurements' do
    count = DepthCounter.new(puzzle_input).total_increments
    expect(count).to be(1754)
  end

  it 'counts using window measurement' do
    count = DepthCounter.new(puzzle_input).total_window_measurement_increments

    expect(count).to be(1789)
  end
end
