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
    return false unless scanned.key?(line)

    scanned[line].any? { |_character, count| count == times }
  end

  def lines_that_repeat(times)
    scanned.select do |line, _counts|
      line_repeats?(line, times)
    end.compact.keys
  end

  def difference_count(line, another_line)
    count = 0

    first_characters = box_ids(line)
    second_characters = box_ids(another_line)

    first_characters.each_index do |index|
      count += 1 if first_characters[index] != second_characters[index]
    end

    count
  end

  def common_characters(line, another_line)
    first_characters = box_ids(line)
    second_characters = box_ids(another_line)

    letters = ''

    first_characters.each_index do |index|
      if first_characters[index] == second_characters[index]
        letters << first_characters[index]
      end
    end

    letters
  end

  def lines_that_differ(character_count = 1)
    lines = records
    differences = {}

    records.each do |line|
      matches = lines.select do |another_line|
        difference_count(line, another_line) == character_count
      end

      differences[line] = matches if matches.count > 0
    end

    differences.first.flatten unless differences.keys.empty?
  end

  def checksum
    multipliers = [
      lines_that_repeat(2).count,
      lines_that_repeat(3).count
    ]

    multipliers.inject(:*) || 0
  end
end
