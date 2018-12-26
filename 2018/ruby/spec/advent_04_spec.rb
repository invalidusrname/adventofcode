require 'spec_helper'
require 'advent_04'

describe 'SleepAnalyzer' do
  let(:puzzle_input) do
    File.readlines('spec/fixtures/advent-04.txt').map(&:chomp)
  end

  let(:sample_input) do
    [
      "[1518-11-01 00:00] Guard #10 begins shift",
      "[1518-11-01 00:05] falls asleep",
      "[1518-11-01 00:25] wakes up",
      "[1518-11-01 00:30] falls asleep",
      "[1518-11-01 00:55] wakes up",
      "[1518-11-01 23:58] Guard #99 begins shift",
      "[1518-11-02 00:40] falls asleep",
      "[1518-11-02 00:50] wakes up",
      "[1518-11-03 00:05] Guard #10 begins shift",
      "[1518-11-03 00:24] falls asleep",
      "[1518-11-03 00:29] wakes up",
      "[1518-11-04 00:02] Guard #99 begins shift",
      "[1518-11-04 00:36] falls asleep",
      "[1518-11-04 00:46] wakes up",
      "[1518-11-05 00:03] Guard #99 begins shift",
      "[1518-11-05 00:45] falls asleep",
      "[1518-11-05 00:55] wakes up"
    ]
  end

  it "reads in the file" do
    reader = SleepAnalyzer.new(sample_input)
    reader.process
  end

  it "solves the puzzle" do
    reader = SleepAnalyzer.new(puzzle_input)
    reader.process

    expect(reader.part_1).to eq(11_367)
    expect(reader.part_2).to eq(36_896)
  end
end
