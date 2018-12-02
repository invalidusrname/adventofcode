class Scanner
  attr_accessor :scanned
  attr_reader :records

  def initialize(records)
    @records = records
    @scanned = {}
  end

  def box_ids(line)
    line.split('')
  end

  def count_characters(characters)
    counts = {}
    characters.each do |character|
      if counts.key?(character)
        counts[character] += 1
      else
        counts[character] = 1
      end
    end

    counts
  end

  def scan
    records.each do |line|
      characters = box_ids(line)
      scanned[line] = count_characters(characters)
    end
  end

  def line_repeats?(line, times)
    return unless scanned.key?(line)

    scanned[line].any? { |_character, count| count == times }
  end

  def lines_that_repeat(times)
    scanned.select do |line, _counts|
      line_repeats?(line, times)
    end.compact.keys
  end

  def checksum
    multipliers = [
      lines_that_repeat(2).count,
      lines_that_repeat(3).count
    ]

    multipliers.inject(:*) || 0
  end
end
