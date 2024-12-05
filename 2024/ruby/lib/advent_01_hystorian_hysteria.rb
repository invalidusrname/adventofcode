require "pry"

class DistanceCalculator
  def initialize(list_one, list_two)
    raise "lists must be the same length" if list_one.length != list_two.length

    @list_one = list_one
    @list_two = list_two
  end

  def total_distance
    sorted_one = @list_one.sort
    sorted_two = @list_two.sort

    pairs = []

    sorted_one.each_index do |i|
      pairs << [sorted_one[i], sorted_two[i]]
    end

    pairs.sum { |pair| distance(pair[0], pair[1]) }
  end

  def distance(left, right)
    (left - right).abs
  end

  def similarity(number)
    @list_two.select { |n| n == number }.length * number
  end

  def total_similarity_score
    @list_one.sum { |number| similarity(number) }
  end
end
