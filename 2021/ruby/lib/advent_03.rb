class BinaryDiagnostic
  def initialize(data)
    @data = data
    @word_length = data[0].to_s.length
  end

  def most_common_bit(data, index)
    zero_count, one_count = bit_count(data, index)
    one_count >= zero_count ? 1 : 0
  end

  def bit_count(data, index)
    zero_count = 0
    one_count = 0

    data.each do |d|
      if d[index].to_i.zero?
        zero_count += 1
      else
        one_count += 1
      end
    end

    [zero_count, one_count]
  end

  def least_common_bit(data, index)
    zero_count, one_count = bit_count(data, index)
    one_count >= zero_count ? 0 : 1
  end

  def episolon_rate
    result = (0...@word_length).map { |index| least_common_bit(@data, index) }
    result.join('').to_i(2)
  end

  def gamma_rate
    result = (0...@word_length).map { |index| most_common_bit(@data, index) }
    result.join('').to_i(2)
  end

  def power_consumption
    episolon_rate * gamma_rate
  end

  def oxygen_generator_rating
    to_process = @data.map(&:clone)
    rating = 0

    (0...@word_length).each do |index|
      bit = most_common_bit(to_process, index)
      to_process.select! { |e| e[index] == bit.to_s }

      if to_process.length == 1
        rating = to_process[0].to_i(2)
        break
      end
    end

    rating
  end

  def co2_scubber_rating
    to_process = @data.map(&:clone)
    rating = 0

    (0...@word_length).each do |index|
      bit = least_common_bit(to_process, index)
      to_process.select! { |e| e[index] == bit.to_s }

      if to_process.length == 1
        rating = to_process[0].to_i(2)
        break
      end
    end

    rating
  end

  def life_support_rating
    oxygen_generator_rating * co2_scubber_rating
  end
end
