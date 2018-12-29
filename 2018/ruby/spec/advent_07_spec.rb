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

  def get_nodes(input, weighted = false, seed_weight = 0)
    input.flatten.uniq.collect do |n|
      if weighted
        WeightedNode.new(n, seed_weight)
      else
        Node.new(n)
      end
    end
  end

  def get_edges(input, nodes)
    input.map do |pair|
      node_x = nodes.detect { |n| n.name == pair[0] }
      node_y = nodes.detect { |n| n.name == pair[1] }

      [node_x, node_y]
    end
  end

  def create_graph(input, weighted = false, seed_weight = 0)
    nodes = get_nodes(input, weighted, seed_weight)
    edges = get_edges(input, nodes)

    graph = Graph.new(nodes)
    edges.each { |item| graph.add_dependency(item[1], item[0]) }

    graph
  end

  it "figures out the sample order" do
    graph = create_graph(sample_input)

    orderer = Orderer.new(graph)
    orderer.process

    expect(orderer.compressed_order).to eq("CABDFE")
  end

  xit "figures out the puzzle order" do
    graph = create_graph(puzzle_input)

    orderer = Orderer.new(graph)
    orderer.process

    expect(orderer.compressed_order).to eq("BHRTWCYSELPUVZAOIJKGMFQDXN")
  end

  it "figures out part 2 sample order" do
    graph = create_graph(sample_input, true, 0)

    orderer = Orderer.new(graph)
    seconds = orderer.process_with_workers(2)

    expect(seconds).to eq(15)
  end

  xit "figures out part 2 puzzle order" do
    graph = create_graph(puzzle_input, true, 60)

    orderer = Orderer.new(graph)
    seconds = orderer.process_with_workers(5)

    expect(seconds).to eq(959)
  end
end
