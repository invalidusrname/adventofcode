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

  def horizontal_word(row, col)
    first = col
    last = col + word.length - 1

    return "" unless in_bounds?(first, last)

    data[row][first..last] * ''
  end

  def horizontal?(row, col)
    match?(horizontal_word(row, col))
  end

  def vertical_word(row, col)
    first = row
    last = row + word.length - 1

    return "" unless in_bounds?(first, last)

    str = ""

    data.each_index do |r|
      data[r].each_index do |c|
        str << data[r][c] if col == c && r.between?(first, last)
      end
    end

    str
  end

  def vertical?(row, col)
    match?(vertical_word(row, col))
  end

  def diagonal_top_left_word(row, col)
    str = ""

    (0..word.length - 1).each do |pos|
      new_row = row - pos
      new_col = col - pos

      return str unless in_bounds?(new_row, new_col)

      str += data[new_row][new_col]
    end

    str
  end

  def diagonal_top_right_word(row, col)
    str = ""

    (0..word.length - 1).each do |pos|
      new_row = row - pos
      new_col = col + pos

      return str unless in_bounds?(new_row, new_col)

      str += data[new_row][new_col]
    end

    str
  end

  def letter_at(row, col)
    in_bounds?(row, col) ? data[row][col] : ""
  end

  def diagonal_bottom_right_word(row, col)
    str = ""

    (0..word.length - 1).each do |pos|
      new_row = row + pos
      new_col = col + pos

      return str unless in_bounds?(new_row, new_col)

      str += data[new_row][new_col]
    end

    str
  end

  def diagonal_bottom_left_word(row, col)
    str = ""

    (0..word.length - 1).each do |pos|
      new_row = row + pos
      new_col = col - pos

      return str unless in_bounds?(new_row, new_col)

      str += data[new_row][new_col]
    end

    str
  end

  def match?(str)
    [str, str.reverse].any? { |w| w == word }
  end

  def cross_word_at?(row, col)
    cross_word = "MAS"

    diag_1 = letter_at(row-1, col-1) + letter_at(row, col) + letter_at(row+1, col+1)
    diag_2 = letter_at(row+1, col-1) + letter_at(row, col) + letter_at(row-1, col+1)

    diag_1_match = [cross_word, cross_word.reverse].any? { |str| str == diag_1 }
    diag_2_match = [cross_word, cross_word.reverse].any? { |str| str == diag_2 }

    diag_1_match && diag_2_match
  end

  def cross_word_count
    count = 0

    data.each_index do |x|
      data[x].each_index do |y|
        count += 1 if cross_word_at?(x, y)
      end
    end

    count
  end

  def word_count
    count = 0

    data.each_index do |x|
      data[x].each_index do |y|
        count += count_at(x, y)
      end
    end

    count
  end

  def vertical_count
    count = 0
    data.each_index do |x|
      data[x].each_index do |y|
        count += 1 if vertical?(x, y)
      end
    end

    count
  end

  def horizonal_count
    count = 0
    data.each_index do |x|
      data[x].each_index do |y|
        count += 1 if horizontal?(x, y)
      end
    end

    count
  end

  def diagonal_count_at(row, col)
    count = 0
    count += 1 if diagonal_top_right_word(row, col) == word
    count += 1 if diagonal_top_left_word(row, col) == word
    count += 1 if diagonal_bottom_right_word(row, col) == word
    count += 1 if diagonal_bottom_left_word(row, col) == word
    count
  end

  def diagonal_count
    count = 0

    data.each_index do |x|
      data[x].each_index do |y|
        count += diagonal_count_at(x, y)
      end
    end

    count
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
