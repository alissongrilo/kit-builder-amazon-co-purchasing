# frozen_string_literal: true

class Graph
  def initialize(vertices_quantity)
    @vertices_quantity = vertices_quantity
    # O grafo é representado como um hash de listas de adjacências.
    @graph = Hash.new { |hash, key| hash[key] = [] }
    @time = 0
  end

  # Lê um grafo de um arquivo e adiciona as arestas ao grafo.
  def read(file_path)
    File.open(file_path).each do |line|
      u, v = line.split.map(&:to_i)
      add_edge(u, v)
    end
  end

  # Método principal para encontrar componentes fortemente conectados no grafo.
  def scc
    disc = Array.new(@vertices_quantity, -1)
    low = Array.new(@vertices_quantity, -1)
    stack_member = Array.new(@vertices_quantity, false)
    st = []

    @scc_count = 0
    @component_with_max_vertices = 0
    @component_with_min_vertices = 0

    # Itera sobre todos os vértices, chamando o método scc_iterative para cada vértice não descoberto.
    (0..(@vertices_quantity - 1)).each do |i|
      scc_iterative(i, low, disc, stack_member, st) if disc[i] == -1
    end

    analyze
  end

  private

  # Exibe as informações sobre os CFC's encontrados.
  def analyze
    puts "Total SCC: #{@scc_count}"
    puts "Min component size: #{@component_with_min_vertices}"
    puts "Max component size: #{@component_with_max_vertices}"
    puts "AVG component size: #{(@vertices_quantity.to_f / @scc_count).round(2)}"
  end

  # Realiza a busca iterativa em profundidade para encontrar componentes fortemente conectados.
  def scc_iterative(start, low, disc, stack_member, st)
    stack = []
    stack.push([start, 0])

    until stack.empty?
      current, state = stack.pop

      case state
      # Estado 0: Inicializa as informações de descoberta e empilha os vértices adjacentes não descobertos.
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

      # Estado 1: Atualiza os tempos mais baixos alcançáveis pelos vértices adjacentes.
      when 1
        @graph[current].each do |v|
          low[current] = [low[current], low[v]].min if stack_member[v]
        end
      end

      # Verifica se o vértice atual é a raiz de um componente fortemente conectado.
      next unless state == 1 && low[current] == disc[current]

      component_size = 0
      w = -1

      # Loop para desempilhar e exibir os vértices do componente.
      loop do
        w = st.pop
        print "#{w} "
        stack_member[w] = false
        component_size += 1
        break if w == current
      end

      puts

      @scc_count += 1
      @component_with_max_vertices = component_size if component_size > @component_with_max_vertices

      if component_size < @component_with_min_vertices || @component_with_min_vertices.zero?
        @component_with_min_vertices = component_size
      end
    end
  end

  # Adiciona uma aresta ao grafo.
  def add_edge(u, v)
    @graph[u] << v
  end
end
