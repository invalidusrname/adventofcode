require 'spec_helper'
require 'advent_06'

describe 'ChronalCoordinates' do
  let(:puzzle_input) do
    File.readlines('spec/fixtures/advent-06.txt').map do |line|
      line.chomp.split(',').collect(&:to_i)
    end
  end

  let(:sample_input) do
    [
      [1, 1],
      [1, 6],
      [8, 3],
      [3, 4],
      [5, 5],
      [8, 9]
    ]
  end

  it "reduces some sample input" do
    coordinates = sample_input.collect do |item|
      Coordinate.new(item[0], item[1])
    end

    c = ChronalCoordinates.new(coordinates)
    # c.print_grid

    expect(c.largest_area).to eq(17)
  end

  xit "solves part 1" do
    coordinates = puzzle_input.collect do |item|
      Coordinate.new(item[0], item[1])
    end

    c = ChronalCoordinates.new(coordinates)
    # c.print_grid

    expect(c.largest_area).to eq(3401)
  end

  it "solves part 2" do
    coordinates = puzzle_input.collect do |item|
      Coordinate.new(item[0], item[1])
    end

    c = ChronalCoordinates.new(coordinates)
    expect(c.largest_region).to eq(49_327)
  end
end
