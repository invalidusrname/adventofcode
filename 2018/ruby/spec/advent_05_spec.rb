require 'spec_helper'
require 'advent_05'

describe 'AlchemicalReduction' do
  let(:puzzle_input) do
    File.read('spec/fixtures/advent-05.txt').chomp
  end

  let(:sample_input) do
    {
      "aA" => "",
      "abBA" => "",
      "abAB" => "abAB",
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

  xit "solves part 1" do
    reader = AlchemicalReduction.new(puzzle_input)
    reader.process

    expect(reader.reduction.length).to eq(9348)
  end

  it "reduces polymer by stripping a single letter" do
    counts = {}
    puzzle_input = 'dabAcCaCBAcCcaDA'

    ('a'..'d').each do |letter|
      new_input = puzzle_input.tr(letter, '')
      new_input = new_input.tr(letter.upcase, '')

      reader = AlchemicalReduction.new(new_input)
      reader.process

      # puts "[#{letter}] #{new_input} -> #{reader.reduction} [#{reader.reduction.length}]"

      length = reader.reduction.length
      counts[letter] = length
    end

    # puts counts
    lowest = counts.min_by { |_key, value| value }

    expect(lowest[0]).to eq("c")
    expect(lowest[1]).to eq(4)
  end

  xit "solves part 2" do
    counts = {}

    ('a'..'z').each do |letter|
      new_input = puzzle_input.tr(letter, '')
      new_input = new_input.tr(letter.upcase, '')

      reader = AlchemicalReduction.new(new_input)
      reader.process
      length = reader.reduction.length

      # puts "#{letter}: #{length}"
      counts[letter] = length
    end

    lowest = counts.min_by { |_key, value| value }

    expect(lowest[0]).to eq("f")
    expect(lowest[1]).to eq(4996)
  end
end
