class DepthCounter
  def initialize(data)
    @data = data
  end

  def total_increments
    count = 0
    previous = @data[0]

    @data.each do |current|
      count += 1 if current > previous
      previous = current
    end

    count
  end

  def window_total(index)
    a = @data[index] || 0
    b = @data[index + 1] || 0
    c = @data[index + 2] || 0

    a + b + c
  end

  def total_window_measurement_increments
    count = 0

    return count if @data.length < 3

    previous = @data[0] + @data[1] + @data[2]

    @data.each_index do |i|
      current = window_total(i)
      count += 1 if current > previous
      previous = current
    end

    count
  end
end
