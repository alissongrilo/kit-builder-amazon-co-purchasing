# frozen_string_literal: true

require './graph'

describe 'Graph' do
  context 'testing scc' do
    it 'should return the correct scc' do
      file = File.new('test.txt', 'w')
      file.puts("0 1\n1 2\n2 0\n1 3\n3 4\n")
      file.close

      graph = Graph.new(5)
      graph.read(file.path)

      File.delete(file.path)

      expect { graph.scc }.to output(
        "4 \n3 \n2 1 0 \nTotal SCC: 3\nMin component size: 1\nMax component size: 3\nAVG component size: 1.67\n"
      )
        .to_stdout
    end

    it 'should return the correct scc' do
      file = File.new('test.txt', 'w')
      file.puts("0 1\n1 2\n2 3\n")
      file.close

      graph = Graph.new(4)
      graph.read(file.path)

      File.delete(file.path)

      expect { graph.scc }.to output(
        "3 \n2 \n1 \n0 \nTotal SCC: 4\nMin component size: 1\nMax component size: 1\nAVG component size: 1.0\n"
      )
        .to_stdout
    end

    it 'should return the correct scc' do
      file = File.new('test.txt', 'w')
      file.puts("0 1\n1 2\n2 0\n1 3\n1 4\n1 6\n3 5\n4 5\n")
      file.close

      graph = Graph.new(7)
      graph.read(file.path)

      File.delete(file.path)

      expect { graph.scc }.to output(
        "5 \n3 \n4 \n6 \n2 1 0 \nTotal SCC: 5\nMin component size: 1\nMax component size: 3\nAVG component size: 1.4\n"
      )
        .to_stdout
    end

    it 'should return the correct scc' do
      file = File.new('test.txt', 'w')
      file.puts("0 1\n1 2\n2 3\n2 4\n3 0\n4 2\n")
      file.close

      graph = Graph.new(5)
      graph.read(file.path)

      File.delete(file.path)

      expect { graph.scc }.to output(
        "4 3 2 1 0 \nTotal SCC: 1\nMin component size: 5\nMax component size: 5\nAVG component size: 5.0\n"
      )
        .to_stdout
    end
  end
end
