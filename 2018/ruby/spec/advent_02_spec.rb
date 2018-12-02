require 'spec_helper'
require 'advent_02'

describe 'Scanner' do
  let(:puzzle_input) do
    File.readlines('spec/fixtures/advent-02.txt').map(&:chomp)
  end

  let(:sample_input) do 
    [
      'bababc',
      'abbcde',
      'abcccd',
      'aabcdd',
      'abcdee',
      'ababab',
    ]
  end

  it "knows when a row contains no letters that repeat" do
    input = 'abcdef'

    scanner = Scanner.new([input])
    scanner.scan

    expect(scanner.lines_that_repeat(2)).to eq([])

    expect(scanner.checksum()).to eq(0)
  end

  it "knows how to count 2 and 3 repeats" do
    scanner = Scanner.new(sample_input)
    scanner.scan

    twice = ["bababc", "abbcde", "aabcdd", "abcdee"]
    thrice = ["bababc", "abcccd", "ababab"]

    expect(scanner.lines_that_repeat(2)).to eq(twice)
    expect(scanner.lines_that_repeat(3)).to eq(thrice)
  end

  it "calculates a checksum" do
    scanner = Scanner.new(sample_input)
    scanner.scan

    expect(scanner.checksum()).to eq(12)
  end

  it "calculates a checksum", solution: true do
    print puzzle_input
    scanner = Scanner.new(puzzle_input)
    scanner.scan

    expect(scanner.checksum()).to eq(5434)
  end
end
