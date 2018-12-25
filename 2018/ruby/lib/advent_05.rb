require 'date'

class Unit
  @@positives = ('a'..'z')
  @@negatives = ('A'..'Z')

  attr_reader :value

  def initialize(value)
    @value = value
  end

  def type
    value.to_s.downcase
  end

  def positive?
    @@positives.include?(value)
  end

  def negative?
    @@negatives.include?(value)
  end
end

class Polymer

  def initialize(unit_a, unit_b)
    @unit_a = unit_a
    @unit_b = unit_b
  end

  def same_type?
    @unit_a.type == @unit_b.type
  end

  def opposite_polarity?
    ((@unit_a.positive? && @unit_b.negative?)) ||
      ((@unit_a.negative? && @unit_b.positive?))
  end

  def destroy?
    same_type? && opposite_polarity?
  end

end

class AlchemicalReduction

  attr_reader :line
  attr_accessor :reduction

  def initialize(line)
    @line = line
    @reduction = ""
  end

  def reduce(chars)
    chars.each_index do |i|
      next if i == 0

      unit_a = Unit.new(chars[i-1])
      unit_b = Unit.new(chars[i])

      polymer = Polymer.new(unit_a, unit_b)

      if polymer.destroy?
        chars[i-1] = nil
        chars[i] = nil
      end
    end

    chars.compact
  end

  def process
    reduced = line.chars

    loop do
      length = reduced.length
      reduced = reduce(reduced)
      break if reduced.length == length
    end

    @reduction = reduced.flatten * ''
  end
end
