class WordSearch
  attr_reader :data, :word

  def initialize(data, word = "XMAS")
    @data = data
    @word = word
  end

  def in_bounds?(row, col)
    row.between?(0, data.length - 1) && col.between?(0, data[row].length - 1)
  end

  def count_at(row, col)
    count = 0
    count += 1 if horizontal?(row, col)
    count += 1 if vertical?(row, col)
    count += diagonal_count_at(row, col)
    count
  end

  def letter_at(row, col)
    in_bounds?(row, col) ? data[row][col] : ""
  end

  def horizontal_word(row, col)
    first = col
    last = col + word.length - 1

    return "" unless in_bounds?(first, last)

    data[row][first..last] * ""
  end

  def horizontal?(row, col)
    match?(horizontal_word(row, col))
  end

  def vertical_word(row, col)
    (row..row + word.length - 1).map do |pos|
      letter_at(pos, col)
    end * ""
  end

  def vertical?(row, col)
    match?(vertical_word(row, col))
  end

  def diagonal_top_left_word(row, col)
    (0..word.length - 1).map do |pos|
      letter_at(row - pos, col - pos)
    end * ""
  end

  def diagonal_top_right_word(row, col)
    (0..word.length - 1).map do |pos|
      letter_at(row - pos, col + pos)
    end * ""
  end

  def diagonal_bottom_right_word(row, col)
    (0..word.length - 1).map do |pos|
      letter_at(row + pos, col + pos)
    end * ""
  end

  def diagonal_bottom_left_word(row, col)
    (0..word.length - 1).map do |pos|
      letter_at(row + pos, col - pos)
    end * ""
  end

  def match?(str)
    [str, str.reverse].any? { |w| w == word }
  end

  def cross_word_at?(row, col)
    cross_word = "MAS"

    diag_1 = letter_at(row - 1, col - 1) + letter_at(row, col) + letter_at(row + 1, col + 1)
    diag_2 = letter_at(row + 1, col - 1) + letter_at(row, col) + letter_at(row - 1, col + 1)

    diag_1_match = [cross_word, cross_word.reverse].any? { |str| str == diag_1 }
    diag_2_match = [cross_word, cross_word.reverse].any? { |str| str == diag_2 }

    diag_1_match && diag_2_match
  end

  def cross_word_count
    data.each_index.sum do |x|
      data[x].each_index.sum do |y|
        cross_word_at?(x, y) ? 1 : 0
      end
    end
  end

  def word_count
    data.each_index.sum do |x|
      data[x].each_index.sum do |y|
        count_at(x, y)
      end
    end
  end

  def vertical_count
    data.each_index.sum do |x|
      data[x].each_index.sum do |y|
        vertical?(x, y) ? 1 : 0
      end
    end
  end

  def horizonal_count
    data.each_index.sum do |x|
      data[x].each_index.sum do |y|
        horizontal?(x, y) ? 1 : 0
      end
    end
  end

  def diagonal_count_at(row, col)
    [
      diagonal_top_right_word(row, col),
      diagonal_top_left_word(row, col),
      diagonal_bottom_right_word(row, col),
      diagonal_bottom_left_word(row, col)
    ].sum { |str| str == word ? 1 : 0 }
  end

  def diagonal_count
    data.each_index.sum do |x|
      data[x].each_index.sum do |y|
        diagonal_count_at(x, y)
      end
    end
  end

  def log_match(prefix, row, col, check)
    puts "[#{prefix} MATCH] #{row}, #{col}: #{data[row][col]} [#{check}]"
  end

  def render
    data.each_index do |x|
      data[x].each_index do |y|
        print " #{data[x][y]} "
      end
      puts
    end
  end
end

def badName
  return unless something

  test
end
