require "spec_helper"
require "advent_05_print_queue"

describe "Puzzle" do
  context "with sample data" do
    let(:data) do
      DataReader.new("./spec/fixtures/advent-05-sample.txt")
    end

    it "knows the ordering rules" do
      result = data.ordering_rules

      expected = [
        "47|53", "97|13", "97|61", "97|47", "75|29", "61|13", "75|53",
        "29|13", "97|29", "53|29", "61|53", "97|53", "61|29", "47|13",
        "75|47", "97|75", "47|61", "75|61", "47|29", "75|13", "53|13"
      ]

      expect(result).to eq(expected)
    end

    it "knows the pages to produce" do
      result = data.pages_to_produce

      expected = %w[
        75,47,61,53,29
        97,61,53,29,13
        75,29,13
        75,97,47,61,53
        61,13,29
        97,13,75,29,47
      ]

      expect(result).to eq(expected)
    end

    it "knows the rules for a number" do
      rules = data.create_rules
      page_update = PageUpdate.new([])

      orderer = Orderer.new(rules, page_update)

      rules = orderer.rules_for(75)

      before_numbers = rules.map(&:before_page).sort

      expect(before_numbers).to eq([13, 29, 47, 53, 61])
    end

    it "knows which pages a number goes before" do
      rules = data.create_rules
      page_update = PageUpdate.new([75, 47, 61, 53, 29])

      orderer = Orderer.new(rules, page_update)

      expect(orderer.lower_priority_pages_for(75)).to eq([29, 47, 53, 61])
    end

    it "knows if a page update is in the right order" do
      rules = data.create_rules
      page_update = PageUpdate.new([75, 47, 61, 53, 29])

      orderer = Orderer.new(rules, page_update)

      expect(orderer.in_order?).to be(true)
    end

    it "knows if a page update is in the right order 2" do
      rules = data.create_rules
      page_update = PageUpdate.new([97, 61, 53, 29, 13])

      orderer = Orderer.new(rules, page_update)

      expect(orderer.in_order?).to be(true)
    end

    it "knows if a page update is in the right order 3" do
      rules = data.create_rules
      page_update = PageUpdate.new([75, 29, 13])

      orderer = Orderer.new(rules, page_update)

      expect(orderer.in_order?).to be(true)
    end

    it "knows when a page update is in the wrong order" do
      rules = data.create_rules
      page_update = PageUpdate.new([75, 97, 47, 61, 53])

      orderer = Orderer.new(rules, page_update)

      expect(orderer.in_order?).to be(false)
    end

    it "knows when a page update is in the wrong order 2" do
      rules = data.create_rules
      page_update = PageUpdate.new([61, 13, 29])

      orderer = Orderer.new(rules, page_update)

      expect(orderer.in_order?).to be(false)
    end

    it "knows when a page update is in the wrong order 3" do
      rules = data.create_rules
      page_update = PageUpdate.new([97, 13, 75, 29, 47])

      orderer = Orderer.new(rules, page_update)

      expect(orderer.in_order?).to be(false)
    end

    it "knows the correctly-ordered updates" do
      rules = data.create_rules
      page_updates = data.create_page_updates

      scanner = RuleScanner.new(rules, page_updates)

      valid = scanner.valid_updates

      expect(valid.length).to be(3)

      expect(valid[0].numbers).to eq([75, 47, 61, 53, 29])
      expect(valid[0].middle_number).to eq(61)

      expect(valid[1].numbers).to eq([97, 61, 53, 29, 13])
      expect(valid[1].middle_number).to eq(53)

      expect(valid[2].numbers).to eq([75, 29, 13])
      expect(valid[2].middle_number).to eq(29)
    end

    it "knows how to reorder" do
      rules = data.create_rules
      page_update = PageUpdate.new([75, 97, 47, 61, 53])

      orderer = Orderer.new(rules, page_update)

      expect(orderer.reorder.numbers).to eq([97, 75, 47, 61, 53])
    end
  end

  context "with puzzle data" do
    let(:data) do
      DataReader.new("./spec/fixtures/advent-05.txt")
    end

    it "solves part i" do
      rules = data.create_rules
      page_updates = data.create_page_updates

      scanner = RuleScanner.new(rules, page_updates)

      expect(scanner.valid_total).to eq(6260)
    end

    it "solves part ii" do
      rules = data.create_rules
      page_updates = data.create_page_updates

      scanner = RuleScanner.new(rules, page_updates)

      expect(scanner.invalid_total).to eq(5346)
    end
  end
end
