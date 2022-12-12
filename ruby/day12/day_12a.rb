# frozen_string_literal: true

require_relative './node'

class Day12A
  attr_accessor :nodes

  def initialize
    @nodes = []
    @landscape = File.open('input.txt').read.split("\n").map { |line| line.split('') }
    @landscape.each_with_index do |row, i|
      nodes << []
      row.each_with_index do |value, j|
        nodes[i] << Node.new(value, [i, j])
        @start_node = nodes[i][-1] if value == 'S'
        @end_node = nodes[i][-1] if value == 'E'
      end
    end
    @start_node.distance_to_start = 0
    @start_node.value = 'a'
    @end_node.value = 'z'
    @end_node.set_end
    nodes.each do |row|
      row.each do |node|
        set_neighbours(node)
      end
    end
  end

  def process
    puts "Starting processing!"
    @nodes_to_process = [@start_node] 
    @visited_nodes = []
    while @nodes_to_process.length > 0
      node = @nodes_to_process[0]
      @visited_nodes << node
      node.neighbors.each do |neighbor|
        neighbor.distance_to_start = node.distance_to_start + 1 if node.distance_to_start + 1 < neighbor.distance_to_start
        @nodes_to_process << neighbor unless @visited_nodes.include?(neighbor)
      end
      # puts node.distance_to_start
      @nodes_to_process.delete(node)
      # puts "Nodes to process: #{@nodes_to_process.length}, nodes already visited: #{@visited_nodes.length}"
    end
  end

  def set_neighbours(node)
    get_neigbouring_coordinates(node.coordinates).each do |coordinates|
      neighbor = nodes[coordinates[0]][coordinates[1]]
      node.add_neighbor(neighbor) if (neighbor.value.ord-node.value.ord) <= 1
    end
  end

  def get_neigbouring_coordinates(coordinates)
    neighbors_coordinates = []
    neighbors_coordinates << [coordinates[0]-1, coordinates[1]] if coordinates[0] > 0
    neighbors_coordinates << [coordinates[0] + 1, coordinates[1]] if coordinates[0] < @landscape.length - 1
    neighbors_coordinates << [coordinates[0], coordinates[1] - 1] if coordinates[1] > 0
    neighbors_coordinates << [coordinates[0], coordinates[1] + 1] if coordinates[1] < @landscape[0].length - 1
    neighbors_coordinates
  end

  def print_answer
    puts @end_node.distance_to_start
  end

  def show_reachable_regions
    nodes.each_with_index do |row, i|
      row.each_with_index do |node,j|
        if node.distance_to_start < 10_000
          print(node.value)
        else 
          print (" ")
        end
      end
      print "\n"
    end
  end
end

exercise = Day12A.new
exercise.process
exercise.print_answer
