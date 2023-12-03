# frozen_string_literal: true

class Graph
  def initialize(vertices_quantity)
    @vertices_quantity = vertices_quantity
    @graph = Hash.new { |hash, key| hash[key] = [] }
    @time = 0
  end

  def read(file_path)
    File.open(file_path).each do |line|
      u, v = line.split.map(&:to_i)
      add_edge(u, v)
    end
  end

  def scc
    disc = Array.new(@vertices_quantity, -1)
    low = Array.new(@vertices_quantity, -1)
    stack_member = Array.new(@vertices_quantity, false)
    st = []

    (0..(@vertices_quantity - 1)).each do |i|
      scc_iterative(i, low, disc, stack_member, st) if disc[i] == -1
    end
  end

  private

  def scc_iterative(start, low, disc, stack_member, st)
    stack = []
    stack.push([start, 0])

    until stack.empty?
      current, state = stack.pop

      case state
      when 0
        disc[current] = @time
        low[current] = @time
        @time += 1
        stack_member[current] = true
        st.push(current)

        stack.push([current, 1])

        @graph[current].reverse_each do |v|
          stack.push([v, 0]) if disc[v] == -1
        end
      when 1
        @graph[current].each do |v|
          low[current] = [low[current], low[v]].min if stack_member[v]
        end
      end

      next unless state == 1 && low[current] == disc[current]

      w = -1
      loop do
        w = st.pop
        print "#{w} "
        stack_member[w] = false
        break if w == current
      end
      puts
    end
  end

  def add_edge(u, v)
    @graph[u] << v
  end
end
