require "spec_helper"
require "advent_02_red_nosed_reports"

describe "Report" do
  context "with safe increasing levels" do
    let(:levels) { [5, 6, 7, 8, 9, 10] }

    it "is safe" do
      report = Report.new(levels)

      expect(report.safe?).to be(true)
    end
  end

  context "with safe decreasing levels" do
    let(:levels) { [5, 4, 3, 2, 1] }

    it "is safe" do
      report = Report.new(levels)

      expect(report.safe?).to be(true)
    end
  end

  context "with mixed levels" do
    let(:levels) { [5, 4, 6] }

    it "is not safe" do
      report = Report.new(levels)

      expect(report.safe?).to be(false)
    end
  end

  context "with bad adjacent levels" do
    let(:levels) { [1, 2, 4, 8, 9] }

    it "is not safe" do
      report = Report.new(levels)

      expect(report.safe?).to be(false)
    end
  end

  context "with sample data" do
    let(:data) do
      File.readlines("spec/fixtures/advent-02-sample.txt").map do |e|
        e.chomp.split(" ").map(&:to_i)
      end
    end

    it "calculates how many are safe" do
      safe = data.select { |levels| Report.new(levels).safe? }

      expect(safe.length).to be(2)
    end

    it "calculates how many are safe with a dampener of 1" do
      safe = data.select { |levels| Report.new(levels).safe_with_dampener? }

      expect(safe.length).to be(4)
    end
  end

  context "with puzzle data" do
    let(:data) do
      File.readlines("spec/fixtures/advent-02.txt").map do |e|
        e.chomp.split(" ").map(&:to_i)
      end
    end

    it "calculates how many are safe" do
      safe = data.select { |levels| Report.new(levels).safe? }

      expect(safe.length).to be(660)
    end

    it "calculates how many are safe with a dampener of 1" do
      safe = data.select { |levels| Report.new(levels).safe_with_dampener? }

      expect(safe.length).to be(689)
    end
  end
end
