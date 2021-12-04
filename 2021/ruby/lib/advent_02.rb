
class DepthCalculator
  def initialize(data)
    @data = data
    @horizontal_position = 0
    @depth = 0
  end

  def process_action(action, amount)
    case action
    when 'forward'
      @horizontal_position += amount
    when 'down'
      @depth += amount
    when 'up'
      @depth -= amount
    end
  end

  def process
    @data.each do |line|
      action, amount = line.split(' ')
      amount = amount.to_i
      process_action(action, amount)
    end
  end

  def product
    @horizontal_position * @depth
  end
end


class AimCalculator
  def initialize(data)
    @data = data
    @horizontal_position = 0
    @aim = 0
    @depth = 0
  end

  def process_action(action, amount)
    case action
    when 'forward'
      @horizontal_position += amount
      @depth += (@aim * amount)
    when 'down'
      @aim += amount
    when 'up'
      @aim -= amount
    end
  end

  def process
    @data.each do |line|
      action, amount = line.split(' ')
      amount = amount.to_i
      process_action(action, amount)

      #puts "#{line} -> AIM: #{@aim} | HORIZONTAL_POSITION: #{@horizontal_position} | DEPTH: #{@depth} | PRODUCT: #{product}"
    end
  end

  def product
    @horizontal_position * @depth
  end
end
