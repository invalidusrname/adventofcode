require 'spec_helper'
require 'advent_07'

describe 'SumOfItsParts' do
  let(:puzzle_input) do
    File.readlines('spec/fixtures/advent-07.txt').map do |line|
      line.scan(/\s([A-Z])\s/).flatten
    end
  end

  let(:sample_input) do
    [
      %w[C A],
      %w[C F],
      %w[A B],
      %w[A D],
      %w[B E],
      %w[D E],
      %w[F E]
    ]
  end

  it "figures out the sample order" do
    input = sample_input
    nodes = input.flatten.uniq.collect { |n| Node.new(n) }

    edges = input.map do |pair|
      node_x = nodes.detect { |n| n.name == pair[0] }
      node_y = nodes.detect { |n| n.name == pair[1] }

      [node_x, node_y]
    end

    graph = Graph.new(nodes)
    edges.each { |item| graph.add_edge(item[1], item[0]) }

    orderer = Orderer.new(graph)

    expect(orderer.compressed_order).to eq("CABDFE")
  end

  it "figures out the puzzle order" do
    input = puzzle_input
    nodes = input.flatten.uniq.collect { |n| Node.new(n) }

    edges = input.map do |pair|
      node_x = nodes.detect { |n| n.name == pair[0] }
      node_y = nodes.detect { |n| n.name == pair[1] }

      [node_x, node_y]
    end

    graph = Graph.new(nodes)
    edges.each { |item| graph.add_edge(item[1], item[0]) }

    orderer = Orderer.new(graph)

    expect(orderer.compressed_order).to eq("BHRTWCYSELPUVZAOIJKGMFQDXN")
  end
end
