class Graph
  attr_accessor :nodes

  def initialize(nodes)
    @nodes = nodes
  end

  def add_dependency(from, to)
    from << to
  end

  def delete_dependent_nodes(node)
    @nodes.each do |n|
      n.dependencies.each do |a|
        remove_node(a, n, node)
      end
    end
  end

  def remove_node(current, parent, node_to_delete)
    if current.dependencies.empty?
      parent.dependencies.delete_if { |n| node_to_delete.to_s == n.to_s }
    else
      current.dependencies.each do |node|
        remove_node(node, parent, node_to_delete)
      end
    end
  end
end

class Node
  attr_accessor :name, :dependencies

  def initialize(name)
    @name = name
    @dependencies = []
  end

  def <<(node)
    dependencies << node
  end

  def to_s
    name
  end
end

class WeightedNode < Node
  attr_accessor :weight

  DURATIONS = ('A'..'Z').each_with_index.map { |l, i| [l, i + 1] }.to_h

  def initialize(name, seed_weight = 0)
    super(name)
    @seed_weight = seed_weight
    @weight = time_required(seed_weight)
  end

  def time_required(seed_weight)
    seed_weight + DURATIONS[@name]
  end
end

class Orderer
  attr_accessor :ordered, :graph

  def initialize(graph)
    @ordered = []
    @graph = graph
  end

  def process
    loop do
      node = next_available_nodes.min_by(&:name)
      ordered << node
      @graph.delete_dependent_nodes(node)
      @graph.nodes.delete_if { |n| node == n }
      break if @graph.nodes.empty?
    end
  end

  def next_available_nodes
    @graph.nodes.select { |n| n.dependencies.empty? } || []
  end

  def next_available_nodes_for_workers(workers)
    @graph.nodes.select do |n|
      n.dependencies.empty? && workers.all? { |w| w.task != n }
    end
  end

  def compressed_order
    ordered.map(&:to_s) * ''
  end

  def print_status(workers, seconds)
    workers.each_with_index do |w, index|
      msg = "[#{seconds}] WORKER #{index + 1}"
      if w.idle?
        puts "#{msg} is idle"
      else
        puts "#{msg} #{w.task} (#{w.current_task_time} | #{w.task.weight})"
      end
    end
  end

  def print_msg(seconds, msg)
    puts "[#{seconds}] #{msg}"
  end

  def process_with_workers(number_of_workers = 5)
    seconds = 0
    workers = Array.new(number_of_workers) { |_t| Worker.new }

    # puts ""

    loop do
      # print_status(workers, seconds)

      workers.each_with_index do |worker, _index|
        worker.tick
        next unless worker.working? && worker.done?

        node = worker.task
        @ordered << node

        # print_msg(seconds, "WORKER #{_index + 1} completed #{node}")

        @graph.delete_dependent_nodes(node)
        @graph.nodes.delete_if { |n| node == n }
        worker.complete_task
      end

      workers.select(&:idle?).each_with_index do |worker, _index|
        node = next_available_nodes_for_workers(workers).min_by(&:name)
        next unless node

        # puts "[#{seconds}] ASSIGNING #{node} to worker #{_index + 1}"
        worker.add_task(node)
      end

      # print_msg(seconds, "DONE: #{ordered * ''}")

      break if workers.all?(&:idle?) && next_available_nodes_for_workers(workers).empty?

      seconds += 1
    end

    # workers.each_with_index do |w, index|
    #   total = "TOTAL #{w.total_time}"
    #   msg = "Worker #{index + 1}: #{w.seconds_idle} | #{w.seconds_working}"
    #   print_msg(total, msg)
    # end

    seconds
  end
end

class Worker
  attr_reader :task, :current_task_time, :seconds_idle, :seconds_working

  def initialize
    @seconds_idle = 0
    @seconds_working = 0
    @current_task_time = 0
    @task = nil
  end

  def total_time
    seconds_idle + seconds_working
  end

  def add_task(task)
    @task = task
    @current_task_time = 0
  end

  def complete_task
    @task = nil
  end

  def idle?
    task.nil?
  end

  def working?
    !idle?
  end

  def done?
    @current_task_time >= task.weight
  end

  def tick
    if working?
      @current_task_time += 1
      @seconds_working += 1
    else
      @seconds_idle += 1
    end
  end
end
