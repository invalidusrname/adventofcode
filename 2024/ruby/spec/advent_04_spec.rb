require 'spec_helper'
require 'advent_04_ceres_search'

describe 'WordSearch' do
  it 'counts horizontal' do
    data = [
      ['X', 'M', 'A', 'S'],
      ['.', '.', '.', '.'],
      ['.', '.', '.', '.'],
      ['.', '.', '.', '.']
    ]

    search = WordSearch.new(data)
    expect(search.horizonal_count).to eq(1)
  end

  it 'counts horizontal in reverse' do
    data = [
      ['S', 'A', 'M', 'X'],
      ['.', '.', '.', '.'],
      ['.', '.', '.', '.'],
      ['.', '.', '.', '.']
    ]

    search = WordSearch.new(data)

    expect(search.horizonal_count).to eq(1)
  end

  it 'counts vertical' do
    data = [
      ['X', '.', '.', '.'],
      ['M', '.', '.', '.'],
      ['A', '.', '.', '.'],
      ['S', '.', '.', '.']
    ]

    search = WordSearch.new(data)

    expect(search.vertical_count).to eq(1)
  end

  it 'counts vertical in reverse' do
    data = [
      ['S', '.', '.', '.'],
      ['A', '.', '.', '.'],
      ['M', '.', '.', '.'],
      ['X', '.', '.', '.']
    ]

    search = WordSearch.new(data)

    expect(search.vertical_count).to eq(1)
  end

  it 'counts downward diagonal' do
    data = [
      ['X', '.', '.', '.'],
      ['.', 'M', '.', '.'],
      ['.', '.', 'A', '.'],
      ['.', '.', '.', 'S']
    ]

    search = WordSearch.new(data)

    expect(search.diagonal_count).to eq(1)
  end

  it 'counts downward reverse diagonal' do
    data = [
      ['S', '.', '.', '.'],
      ['.', 'A', '.', '.'],
      ['.', '.', 'M', '.'],
      ['.', '.', '.', 'X']
    ]

    search = WordSearch.new(data)

    expect(search.diagonal_count).to eq(1)
  end

  it 'counts upward diagonal' do
    data = [
      ['.', '.', '.', 'S'],
      ['.', '.', 'A', '.'],
      ['.', 'M', '.', '.'],
      ['X', '.', '.', '.']
    ]

    search = WordSearch.new(data)

    expect(search.diagonal_count).to eq(1)
  end

  it 'counts upward reverse diagonal' do
    data = [
      ['.', '.', '.', 'X'],
      ['.', '.', 'M', '.'],
      ['.', 'A', '.', '.'],
      ['S', '.', '.', '.']
    ]

    search = WordSearch.new(data)

    expect(search.diagonal_count).to eq(1)
  end

  it 'counts crossing diagonals' do
    data = [
      ['X', '.', '.', 'S'],
      ['.', 'M', 'A', '.'],
      ['.', 'M', 'A', '.'],
      ['X', '.', '.', 'S']
    ]

    search = WordSearch.new(data)

    expect(search.diagonal_count).to eq(2)
  end

  it 'counts cross diagonals' do
    data = [
      ['S', '.', '.', 'S'],
      ['.', 'A', 'A', '.'],
      ['.', 'M', 'M', '.'],
      ['X', '.', '.', 'X']
    ]

    search = WordSearch.new(data)

    expect(search.diagonal_count).to eq(2)
  end

  it 'finds no matches' do
    data = [
      %w[X X X X],
      %w[X X X M],
      %w[X X X X],
      %w[A X X X],
      %w[X S X X]
    ]

    search = WordSearch.new(data)

    expect(search.diagonal_count).to eq(0)
  end

  it 'counts diagonals' do
    data = [
      ['.', 'S', '.', '.', '.', '.', '.', 'S', '.', '.'],
      ['.', '.', 'A', '.', '.', '.', 'A', '.', '.', '.'],
      ['.', '.', '.', 'M', '.', 'M', '.', '.', '.', '.'],
      ['.', '.', '.', '.', 'X', '.', '.', '.', '.', '.'],
      ['.', '.', '.', 'M', '.', 'M', '.', '.', '.', '.'],
      ['.', '.', 'A', '.', '.', '.', 'A', '.', '.', '.'],
      ['.', 'S', '.', '.', '.', '.', '.', 'S', '.', '.']
    ]

    search = WordSearch.new(data)

    expect(search.diagonal_top_left_word(3, 4)).to eq('XMAS')
    expect(search.diagonal_top_right_word(3, 4)).to eq('XMAS')
    expect(search.diagonal_bottom_right_word(3, 4)).to eq('XMAS')
    expect(search.diagonal_bottom_left_word(3, 4)).to eq('XMAS')

    expect(search.diagonal_count).to eq(4)
    expect(search.word_count).to eq(4)
  end

  it 'counts cross words' do
    data = [
      ['M', '.', 'S'],
      ['.', 'A', '.'],
      ['M', '.', 'S']
    ]

    search = WordSearch.new(data)

    expect(search.cross_word_at?(1, 1)).to be(true)
    expect(search.cross_word_count).to eq(1)
  end

  context 'with sample data' do
    let(:data) do
      File.readlines('./spec/fixtures/advent-04-sample.txt').map { |l| l.chomp.chars }
    end

    it 'finds counts of XMAS' do
      search = WordSearch.new(data)

      expect(search.word_count).to eq(18)
    end
  end

  context 'with puzzle data' do
    let(:data) do
      File.readlines('./spec/fixtures/advent-04.txt').map { |l| l.chomp.chars }
    end

    it 'finds counts of XMAS' do
      search = WordSearch.new(data)

      expect(search.word_count).to eq(2447)
    end

    it 'finds cross word counts' do
      search = WordSearch.new(data)

      expect(search.cross_word_count).to eq(1868)
    end
  end
end
