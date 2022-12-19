# frozen_string_literal: true

require 'pry'
require_relative 'valve'

class Day16
  def initialize
    @file = File.read('input.txt').split("\n")
    @valves = []
    @file.each do |line|
      line =~ (/Valve (.*) has .*=(\d+);.*valves? (.+)$/)
      @valves << Valve.new(Regexp.last_match(1), Regexp.last_match(2).to_i, Regexp.last_match(3).split(', '))
    end
    @relevant_valves = @valves.select { |valve| valve.flow_rate.positive? }
    @valves.each do |valve|
      valve.neighbors = valve.neighbors.map do |neighbor|
        fetch_valve(neighbor)
      end
    end
    @solutions = []
  end

  def fetch_valve(name)
    @valves.each do |valve|
      return valve if valve.name == name
    end
  end

  def visit_child_valve(current_valve, timer_left, total_flow_released, valves_already_visited, stack)
    puts "stack: #{stack}"
    puts "timer_left: #{timer_left}"
    puts "total_flow_released: #{total_flow_released}"
    proper_valves = good_valves(current_valve, valves_already_visited, timer_left)
    puts "proper valves left: #{proper_valves.length}"
    puts "valves_visited: #{valves_already_visited.map(&:name).inspect}"
    puts "\n"
    @solutions << total_flow_released
    proper_valves.each do |valve|
      new_visited_valves = valves_already_visited.clone << valve
      new_timer = timer_left - (current_valve.get_distance_to_valve(valve) + 1)
      total_flow = total_flow_released + (valve.flow_rate * new_timer)
      visit_child_valve(valve, new_timer, total_flow, new_visited_valves, stack + 1)
    end
  end

  def process
    @relevant_valves.each do |valve|
      start_time = 30 - (fetch_valve('AA').get_distance_to_valve(valve) + 1)
      visit_child_valve(valve, start_time, valve.flow_rate * start_time, [valve], 0)
    end
  end

  def good_valves(current_valve, valves_already_visited, timer)
    @relevant_valves.select do |valve|
      !valves_already_visited.include?(valve) && (timer - (current_valve.get_distance_to_valve(valve) - 1 ) >= 0)
    end
  end

  def print_answer
    puts @solutions.count
    puts @solutions.max
  end
end

exercise = Day16.new
exercise.process
exercise.print_answer
