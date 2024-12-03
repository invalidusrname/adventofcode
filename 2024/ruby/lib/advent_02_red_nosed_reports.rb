class Report
  attr_reader :levels

  def initialize(levels)
    @levels = levels
  end

  def initial_direction(levels)
    levels.length > 1 && levels[0] < levels[1] ? 'increasing' : 'decreasing'
  end

  def safe_with_dampener?
    return true if safe?

    levels.each_index do |i|
      dampered_levels = levels.dup
      dampered_levels.delete_at(i)

      direction = initial_direction(dampered_levels)

      return true if safe_levels(direction, dampered_levels)
    end

    false
  end

  def safe_levels(direction, levels)
    levels.each_index do |i|
      next if i == 0

      current = levels[i]
      prev = levels[i - 1]

      return false unless valid_direction?(direction, current, prev) && adjacent_safe?(prev, current)
    end

    true
  end

  def safe?
    direction = initial_direction(levels)

    safe_levels(direction, levels)
  end

  def valid_direction?(direction, level, prev)
    (prev < level && direction == 'increasing') || (prev > level && direction == 'decreasing')
  end

  def adjacent_safe?(prev, level)
    (prev - level).abs.between?(1, 3)
  end
end
