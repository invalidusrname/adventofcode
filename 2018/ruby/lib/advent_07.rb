class Graph
  attr_accessor :nodes

  def initialize(nodes)
    @nodes = nodes
  end

  def add_edge(from, to)
    from << to
  end
end

class Node
  attr_accessor :name, :adjacents

  def initialize(name)
    @name = name
    @adjacents = []
  end

  def <<(node)
    adjacents << node
  end

  def to_s
    name
  end
end

class Orderer
  attr_accessor :ordered

  def initialize(graph)
    @ordered = []

    @nodes = graph.nodes

    loop do
      current_list = @nodes.select { |n| n.adjacents.empty? }
      node = current_list.min_by(&:name)

      @ordered << node

      delete_adjacent_nodes(node)

      @nodes.delete_if { |n| node == n }
      
      break if @nodes.empty?
    end
  end

  def delete_adjacent_nodes(node)
    @nodes.each do |n|
      n.adjacents.each do |a|
        remove_node(a, n, node)
      end
    end
  end

  def remove_node(current, parent, node_to_delete)
    if current.adjacents.empty?
      parent.adjacents.delete_if { |n| node_to_delete.to_s == n.to_s }
    else
      current.adjacents.each do |adjacent|
        remove_node(adjacent, parent, node_to_delete)
      end
    end
  end

  def compressed_order
    ordered.map(&:to_s) * ''
  end
end
