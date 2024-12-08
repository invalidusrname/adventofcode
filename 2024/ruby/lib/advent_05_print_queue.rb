class DataReader
  def initialize(file)
    @lines = File.readlines(file).map(&:strip)
  end

  def empty_line_index
    @lines.find_index { |line| line == "" }
  end

  def ordering_rules
    @lines[0...empty_line_index] || []
  end

  def pages_to_produce
    return [] unless empty_line_index

    @lines[empty_line_index + 1..] || []
  end

  def create_rules
    ordering_rules.map do |line|
      Rule.new(*line.split("|").map(&:to_i))
    end
  end

  def create_page_updates
    pages_to_produce.map do |line|
      PageUpdate.new(line.split(",").map(&:to_i))
    end
  end
end

class Rule
  attr_reader :page, :before_page

  def initialize(page, before_page)
    @page = page
    @before_page = before_page
  end
end

class PageUpdate
  attr_reader :numbers

  def initialize(numbers)
    @numbers = numbers
  end

  def middle_number
    numbers.empty? ? nil : numbers[numbers.length / 2]
  end
end

class RuleScanner
  def initialize(rules, page_updates)
    @rules = rules
    @page_updates = page_updates
  end

  def valid_updates
    @page_updates.select do |page_update|
      orderer = Orderer.new(@rules, page_update)
      orderer.in_order?
    end
  end

  def invalid_updates
    @page_updates.reject do |page_update|
      orderer = Orderer.new(@rules, page_update)
      orderer.in_order?
    end
  end

  def valid_total
    valid_updates.sum(&:middle_number)
  end

  def invalid_total
    invalid_updates.map do |page_update|
      orderer = Orderer.new(@rules, page_update)
      orderer.reorder
    end.sum(&:middle_number)
  end
end

class Orderer
  attr_reader :page_update

  def initialize(rules, page_update)
    @rules = rules
    @page_update = page_update
  end

  def rules_for(number)
    @rules.select { |r| r.page == number }
  end

  def scoped_rules_for(number)
    rules_for(number).select { |r| page_update.numbers.include? r.before_page }
  end

  def lower_priority_pages_for(number)
    scoped_rules_for(number).map(&:before_page).sort.uniq
  end

  def in_order?
    pairs = page_update.numbers.each_cons(2)
    pairs.all? { |a, b| lower_priority_pages_for(a).include?(b) }
  end

  def reorder
    numbers = page_update.numbers.to_a
    return [] if numbers.empty?

    numbers.sort! { |a, b| lower_priority_pages_for(a).include?(b) ? -1 : 1 }

    PageUpdate.new(numbers)
  end
end
