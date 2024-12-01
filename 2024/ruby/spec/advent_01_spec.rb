require 'spec_helper'
require 'advent_01_hystorian_hysteria'

describe 'DistanceCalculator' do
  let(:data) do
    File.readlines('./spec/fixtures/advent-01.txt').each do |line|
      line.chomp.gsub(/\s+/, ' ')
    end
  end

  let(:list_one) do
    data.map { |line| line.split(' ')[0].to_i }
  end

  let(:list_two) do
    data.map { |line| line.split(' ')[1].to_i }
  end

  it 'calculates distance' do
    calc = DistanceCalculator.new([], [])

    result = calc.distance(1, 3)

    expect(result).to be(2)
  end

  it 'calculates total distance' do
    calc = DistanceCalculator.new(list_one, list_two)

    expect(calc.total_distance).to eq(2_166_959)
  end

  it 'calculates similarity distance with matching number' do
    a = [3, 4, 2, 1, 3, 3]
    b = [4, 3, 5, 3, 9, 3]
    calc = DistanceCalculator.new(a, b)

    expect(calc.similarity(4)).to eq(4)
  end

  it 'calculates similarity distance with multiple matches' do
    a = [3, 4, 2, 1, 3, 3]
    b = [4, 3, 5, 3, 9, 3]
    calc = DistanceCalculator.new(a, b)

    expect(calc.similarity(3)).to eq(9)
  end

  it 'calculates similarity distance with missing number' do
    a = [3, 4, 2, 1, 3, 3]
    b = [4, 3, 5, 3, 9, 3]
    calc = DistanceCalculator.new(a, b)

    expect(calc.similarity(2)).to eq(0)
  end

  it 'calculates total similarity distance' do
    calc = DistanceCalculator.new(list_one, list_two)

    expect(calc.total_similarity_score).to eq(23_741_109)
  end
end
