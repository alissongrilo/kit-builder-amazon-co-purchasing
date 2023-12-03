# frozen_string_literal: true

require './graph'

FILE_PATH = 'Amazon0302.txt'

graph = Graph.new(File.open(FILE_PATH).readlines.size)
graph.read(FILE_PATH)
graph.scc
