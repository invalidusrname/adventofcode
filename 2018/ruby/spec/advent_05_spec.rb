require 'spec_helper'
require 'advent_05'

describe 'AlchemicalReduction' do
  let(:puzzle_input) do
    File.read('spec/fixtures/advent-05.txt').chomp
  end

  let(:sample_input) do
    {
        "aA"     => "",
        "abBA"   => "",
        "abAB"   => "abAB",
        "aabAAB" => "aabAAB",
    }
  end

  it "reduces some sample input" do
    sample_input.each do |input, result|
        reader = AlchemicalReduction.new(input)
        reader.process

        expect(reader.reduction).to eq(result)
    end
  end

  it "solves the puzzle" do
    reader = AlchemicalReduction.new(puzzle_input)
    reader.process

    expect(reader.reduction.length).to eq(9348)
  end
end
