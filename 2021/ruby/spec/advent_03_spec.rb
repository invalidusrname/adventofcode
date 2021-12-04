require 'spec_helper'
require 'advent_03'

describe 'BinaryDiagnostic' do
  let(:puzzle_input) do
    File.readlines('./spec/fixtures/advent-03.txt').map(&:chomp)
  end

  it 'calculates the sample power consumption' do
    sample_input = %w[
      00100
      11110
      10110
      10111
      10101
      01111
      00111
      11100
      10000
      11001
      00010
      01010
    ]

    dc = BinaryDiagnostic.new(sample_input)
    dc.episolon_rate

    expect(dc.gamma_rate).to be(22)
    expect(dc.episolon_rate).to be(9)
    expect(dc.power_consumption).to be(198)

    expect(dc.oxygen_generator_rating).to be(23)
    expect(dc.co2_scubber_rating).to be(10)
    expect(dc.life_support_rating).to be(230)
  end

  it 'calculates the power consumption' do
    dc = BinaryDiagnostic.new(puzzle_input)

    expect(dc.power_consumption).to be(388_256_4)
  end

  it 'calculates life support rating' do
    dc = BinaryDiagnostic.new(puzzle_input)

    expect(dc.life_support_rating).to be(338_517_0)
  end
end
