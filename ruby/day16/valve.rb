# frozen_string_literal: true

class Valve
  attr_accessor :name, :flow_rate, :neighbors, :already_asked, :already_activated

  def initialize(name, flow_rate, neighbors)
    @name = name
    @flow_rate = flow_rate
    @neighbors = neighbors
    @already_asked = false
    @already_activated = false
    @distances = {}
  end

  def activate
    @already_activated = true
  end

  def get_distance_to_valve(valve)
    @already_asked = true
    return_value = if self == valve
                     0
                   elsif neighbors.include?(valve)
                     1
                   else
                     (@neighbors.map do |neighbor|
                        neighbor.get_distance_to_valve(valve) unless neighbor.already_asked
                      end.compact.min || 10_000) + 1
                   end
    @already_asked = false
    return_value
  end
end
