# frozen_string_literal: true

require './graph'

FILE_PATH = '../amostra-grafo.txt'

graph = Graph.new(80)
graph.read(FILE_PATH)
graph.scc
