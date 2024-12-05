require "spec_helper"
require "advent_03_mull_it_over"

describe "Muller" do
  context "with uncorrupted pieces" do
    let(:data) { File.read("./spec/fixtures/advent-03-sample-ii.txt").chomp }

    it "parses uncorrupted pieces" do
      muller = Muller.new(data)

      expect(muller.uncorrupted_pieces).to eq(["mul(2,4)", "mul(8,5)"])
    end

    it "mulls uncorrupted data" do
      muller = Muller.new(data)

      expect(muller.uncorrupted_mull).to eq(48)
    end
  end

  context "with sample data" do
    let(:data) { File.read("./spec/fixtures/advent-03-sample.txt").chomp }

    it "parses the pieces" do
      muller = Muller.new(data)

      expect(muller.pieces).to eq(["mul(2,4)", "mul(5,5)", "mul(11,8)", "mul(8,5)"])
    end

    it "mulls the data" do
      muller = Muller.new(data)

      expect(muller.mull).to eq(161)
    end
  end

  context "with puzzle data" do
    let(:data) { File.read("./spec/fixtures/advent-03.txt").chomp }

    it "mulls the data" do
      muller = Muller.new(data)

      expect(muller.mull).to eq(165_225_049)
    end

    it "mulls uncorrupted data" do
      muller = Muller.new(data)

      expect(muller.uncorrupted_mull).to eq(108_830_766)
    end
  end
end
