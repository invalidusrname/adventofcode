require 'matrix'

class ClaimReader
  def initialize(raw_claims)
    @raw_claims = raw_claims
  end

  def process
    @raw_claims.map { |line| convert_to_claim(line) }
  end

  def convert_to_claim(line)
    line.strip!
    splits = line.split(" ")
    id = splits.first[1..-1]

    left, top = splits[2].strip.split(":")[0].strip.split(',')
    width, height = splits[3].strip.split(':')[0].split("x")

    offset = Offset.new(left.to_i, top.to_i)
    rectangle = Rectangle.new(width.to_i, height.to_i, offset)

    Claim.new(id, rectangle)
  end
end

class Offset
  attr_reader :left, :top

  def initialize(left, top)
    @left = left
    @top = top
  end
end

class Rectangle
  attr_reader :width, :height, :offset

  def initialize(width, height, offset)
    @width = width
    @height = height
    @offset = offset
  end

  def top_left
    [@offset.top, @offset.left]
  end

  def top_right
    [@offset.top, @offset.left + @width - 1]
  end

  def bottom_left
    [@offset.top + @height - 1, @offset.left]
  end

  def bottom_right
    [@offset.top + @height - 1, @offset.left + @width - 1]
  end

  def in_area?(row, col)
    row.between?(top_left[0], bottom_left[0]) &&
      col.between?(top_left[1], top_right[1])
  end

  def matrix
    row_count = @offset.top + @height
    column_count = @offset.left + @width

    Matrix.build(row_count, column_count) do |row, col|
      in_area?(row, col) ? 1 : 0
    end
  end

  def to_s
    matrix.to_a.each { |r| puts r.inspect }
  end
end

class Claim
  attr_reader :id, :rectangle

  def initialize(id, rectangle)
    @id = id
    @rectangle = rectangle
  end

  def matrix
    @rectangle.matrix
  end

  def to_s
    puts "CLAIM: #{id} "
    matrix.to_a.each { |r| puts r.inspect }
  end
end
