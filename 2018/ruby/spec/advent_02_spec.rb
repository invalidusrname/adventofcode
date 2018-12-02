require 'spec_helper'
require 'advent_02'

describe 'Scanner' do
  let(:puzzle_input) do
    File.readlines('spec/fixtures/advent-02.txt').map(&:chomp)
  end

  let(:sample_input) do
    %w[
      bababc
      abbcde
      abcccd
      aabcdd
      abcdee
      ababab
    ]
  end

  it "knows when a row contains no letters that repeat" do
    input = 'abcdef'

    scanner = Scanner.new([input])
    scanner.scan

    expect(scanner.lines_that_repeat(2)).to eq([])

    expect(scanner.checksum).to eq(0)
  end

  it "knows how to count 2 and 3 repeats" do
    scanner = Scanner.new(sample_input)
    scanner.scan

    twice = %w[bababc abbcde aabcdd abcdee]
    thrice = %w[bababc abcccd ababab]

    expect(scanner.lines_that_repeat(2)).to eq(twice)
    expect(scanner.lines_that_repeat(3)).to eq(thrice)
  end

  it "calculates a checksum" do
    scanner = Scanner.new(sample_input)
    scanner.scan

    expect(scanner.checksum).to eq(12)
  end

  it "calculates a checksum", solution: true do
    scanner = Scanner.new(puzzle_input)
    scanner.scan

    expect(scanner.checksum).to eq(5434)
  end

  it "knows when 2 box ids differ by one character at the same position" do
    input = %w[
      abcde
      fghij
      klmno
      pqrst
      fguij
      axcye
      wvxyz
    ]

    scanner = Scanner.new(input)

    expect(scanner.lines_that_differ).to eq(%w[fghij fguij])
  end

  it "knows the common characters between to box ids" do
    scanner = Scanner.new([])

    expect(scanner.common_characters('fghij', 'fguij')).to eq('fgij')
  end

  it "knows the common characters", solution: true do
    scanner = Scanner.new(puzzle_input)

    matches = scanner.lines_that_differ

    expect(scanner.lines_that_differ).to eq(%w[
                                              agirmdjvlhedpsyoqfzuknpjwt
                                              agitmdjvlhedpsyoqfzuknpjwt
                                            ])

    expect(scanner.common_characters(matches[0], matches[1])).to eq(
      'agimdjvlhedpsyoqfzuknpjwt'
    )
  end
end
