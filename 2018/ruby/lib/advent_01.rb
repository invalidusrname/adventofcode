class FrequencyScanner
  attr_reader :numbers

  def initialize(numbers)
    @numbers = numbers
  end

  def sum
    numbers.inject(0, :+)
  end

  def first_number_reached_twice
    freq = 0
    the_number = nil
    frequencies = [0]

    loop do
      break if the_number

      numbers.each do |number|
        freq += number
        if frequencies.include?(freq)
          # puts "FOUND TWICE"
          the_number = freq
          break
        else
          frequencies << freq
        end
      end
    end

    the_number
  end
end
