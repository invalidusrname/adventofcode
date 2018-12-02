require 'spec_helper'
require 'advent_02'

describe 'FrequencyScanner' do
  let(:puzzle_input) do
    File.readlines('spec/fixtures/advent-01.txt').map(&:to_i)
  end

  it 'sums up some numbers', solution: true do
    scanner = FrequencyScanner.new(puzzle_input)
    sum = scanner.sum
    expect(sum).to eq(490)
  end

  it "knows first number reached twice" do
    examples = {
      [1, -2, 3, 1] => 2,
      [1, -1] => 0,
      [3, 3, 4, -2, -4] => 10,
      [-6, 3, 8, 5, -6] => 5,
      [7, 7, -2, -7, -4] => 14,
    }

    examples.each do |frequencies, resulting_frequency|
      scanner = FrequencyScanner.new(frequencies)
      result = scanner.first_number_reached_twice

      expect(result).to eq(resulting_frequency)
    end
  end

  it "computes the first number reached twice", slow: true do
    scanner = FrequencyScanner.new(puzzle_input)
    result = scanner.first_number_reached_twice

    expect(result).to eq('70357')
  end
end
