# frozen_string_literal: true

class Node
  attr_accessor :value, :distance_to_start
  attr_reader :coordinates, :neighbors

  def initialize(value, coordinates)
    @value = value
    @coordinates = coordinates
    @neighbors = []
    @distance_to_start = 1_000_000
    @end_node = false
  end

  def add_neighbor(node)
    @neighbors << node
  end

  def is_end?
    @end_node
  end

  def set_end
    @end_node = true
  end
end
