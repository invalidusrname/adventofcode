require 'spec_helper'
require 'advent_03'

describe 'ClaimReader' do
  let(:puzzle_input) do
    File.readlines('spec/fixtures/advent-03.txt').map(&:chomp)
  end

  let(:sample_input) do
    [
      "#1 @ 1,3: 4x4",
      "#2 @ 3,1: 4x4",
      "#3 @ 5,5: 2x2"
    ]
  end

  it "reads in the file" do
    reader = ClaimReader.new(sample_input)
    claims = reader.process

    first_claim = claims[0]

    rectangle = first_claim.rectangle

    expect(first_claim.id).to eq("1")
    expect(rectangle.offset.left).to eq(1)
    expect(rectangle.offset.top).to eq(3)
    expect(rectangle.height).to eq(4)
    expect(rectangle.width).to eq(4)
  end

  it "solves the puzzle", solution: true, slow: true do
    reader = ClaimReader.new(puzzle_input)
    claims = reader.process

    fabric = Matrix.zero(1000, 1000)
    overlapping_ids = []

    claims.each_index do |index|
      claim = claims[index]
      matrix = claim.rectangle.matrix

      (0...matrix.row_count).each do |row|
        (0...matrix.column_count).each do |column|
          val = matrix[row, column]
          next unless val == 1

          if fabric[row, column] == 0
            fabric[row, column] = [claim.id]
          else
            fabric[row, column] << claim.id
          end

          fabric[row, column] = fabric[row, column].uniq

          if fabric[row, column].count > 1
            ids = [fabric[row, column].uniq + [claim.id]].flatten.uniq
            overlapping_ids << ids
          end
        end
      end
    end

    count = 0

    (0...fabric.row_count).each do |row|
      (0...fabric.column_count).each do |column|
        e = fabric[row, column]
        count += 1 if e.is_a? Array
      end
    end

    overlapping_ids.flatten!
    overlapping_ids.uniq!

    non_overlapping_claim_id = (claims.collect(&:id) - overlapping_ids).first.to_i

    expect(count).to eq(113_576)
    expect(non_overlapping_claim_id).to eq(825)
  end

  it "knows about a rectangle" do
    # left, top
    offset = Offset.new(3, 2)
    # width, height
    rectangle = Rectangle.new(5, 4, offset)

    expect(rectangle.offset.left).to eq(3)
    expect(rectangle.offset.top).to eq(2)
    expect(rectangle.width).to eq(5)
    expect(rectangle.height).to eq(4)

    expect(rectangle.top_left).to eq([2, 3])
    expect(rectangle.top_right).to eq([2, 7])
    expect(rectangle.bottom_left).to eq([5, 3])
    expect(rectangle.bottom_right).to eq([5, 7])

    # 0 0 0 0 0 0 0 0
    # 0 0 0 0 0 0 0 0
    # 0 0 0 1 1 1 1 1
    # 0 0 0 1 1 1 1 1
    # 0 0 0 1 1 1 1 1
    # 0 0 0 1 1 1 1 1
  end
end
