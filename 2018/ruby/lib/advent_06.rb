class Coordinate
  attr_reader :x, :y, :count
  attr_writer :count

  def initialize(x, y)
    @x = x
    @y = y
    @count = 1
  end

  def to_s
    name
  end

  def name
    "(#{x},#{y})"
  end
end

class ChronalCoordinates
  attr_reader :coordinates

  def initialize(coordinates)
    @coordinates = coordinates

    @grid = {}
    @counts = Hash.new(0)

    fill_grid
    fill_closest
    fill_counts
  end

  def min_x
    @min_x ||= @coordinates.collect(&:x).min
  end

  def max_x
    @max_x ||= @coordinates.collect(&:x).max
  end

  def min_y
    @min_y ||= @coordinates.collect(&:y).min
  end

  def max_y
    @max_y ||= @coordinates.collect(&:y).max
  end

  def infinite_coordinate?(coordinate)
    x = coordinate.x
    y = coordinate.y

    ((min_x == x) || (max_x == x) || (min_y == y) || (max_y == y))
  end

  def infinite_locations
    locations = []

    (min_x..max_x).each do |x|
      (min_y..max_y).each do |y|
        point = Coordinate.new(x, y)
        closest = @grid[point.to_s]
        if closest.is_a?(Coordinate)
          locations << closest if infinite_coordinate?(point)
        end
      end
    end

    locations.uniq
  end

  def largest_area
    infinite = infinite_locations

    allowed = @counts.reject do |c, _total|
      infinite.any? { |i| i.x == c.x && i.y == c.y }
    end

    @counts.collect do |coordinate, total|
      total if allowed.include?(coordinate)
    end.flatten.compact.max
  end

  def get_coordinate(point)
    @coordinates.detect { |c| c.x == point.x && c.y == point.y }
  end

  def manhattan_distance(p, q)
    (p.x - q.x).abs + (p.y - q.y).abs
  end

  def fill_grid
    (min_x..max_x).each do |x|
      (min_y..max_y).each do |y|
        point = Coordinate.new(x, y)
        @grid[point.to_s] = get_coordinate(point) || '.'
      end
    end
  end

  def fill_closest
    (min_x..max_x).each do |x|
      (min_y..max_y).each do |y|
        point = Coordinate.new(x, y)

        next if @grid[point.to_s].is_a?(Coordinate)

        coordinate = closest_coordinate(point)

        if coordinate
          @grid[point.to_s] = coordinate
          # puts "NEAREST [#{point}] => #{coordinate.name}"
        end
      end
    end
  end

  def fill_counts
    @grid.each do |_key, value|
      @counts[value] += 1 if value.is_a?(Coordinate)
    end
  end

  def closest_coordinate(point)
    nearest_distance = nil
    nearest = nil

    # puts "SCANNING: #{point}"

    @coordinates.each do |c|
      distance = manhattan_distance(point, c)

      # puts "CHECKING: #{c} distance #{distance}"

      if nearest_distance.nil?
        nearest_distance = distance
        nearest = c
      elsif distance < nearest_distance
        nearest_distance = distance
        nearest = c
      elsif distance == nearest_distance
        nearest = nil
      end
    end

    # puts "NEAREST -> #{nearest}"

    nearest
  end

  def print_grid
    puts "(#{min_x},#{min_y}) <> (#{max_x},#{max_y})"

    (min_x..max_x).each do |x|
      (min_y..max_y).each do |y|
        point = Coordinate.new(x, y)
        value = @grid[point.to_s].to_s
        print "#{value} "
      end
      puts
    end
  end

  def largest_region
    count = 0

    (min_x..max_x).each do |x|
      (min_y..max_y).each do |y|
        point = Coordinate.new(x, y)

        total = @coordinates.inject(0) do |sum, c|
          sum + manhattan_distance(point, c)
        end

        count += 1 unless total >= 10_000
      end
    end

    count
  end
end
