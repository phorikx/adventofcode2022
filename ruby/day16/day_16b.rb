# frozen_string_literal: true

require 'pry'
require_relative 'valve'

class Day16B
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
  
  def visit_child_valve(current_me_valve, current_elephant_valve, timer_left_me, timer_left_elephant, total_flow_released, valves_already_visited)
    (0..1).each do |i|
      elephant_visit_valve(current_me_valve, current_elephant_valve, timer_left_me, timer_left_elephant, total_flow_released, valves_already_visited) if i==0
      me_visit_valve(current_me_valve, current_elephant_valve, timer_left_me, timer_left_elephant, total_flow_released, valves_already_visited) if i==1
    end
  end

  def elephant_visit_valve(current_me_valve, current_elephant_valve, timer_left_me, timer_left_elephant, total_flow_released, valves_already_visited)
    proper_valves = good_valves(current_elephant_valve, valves_already_visited, timer_left_elephant)
    @solutions << total_flow_released
    proper_valves.each do |valve|
      new_visited_valves = valves_already_visited.clone << valve
      new_timer = timer_left_elephant - (current_elephant_valve.get_distance_to_valve(valve) + 1)
      total_flow = total_flow_released + (valve.flow_rate * new_timer)
      visit_child_valve(current_me_valve, valve, timer_left_me, new_timer, total_flow, new_visited_valves)
    end
  end

  def me_visit_valve(current_me_valve, current_elephant_valve, timer_left_me, timer_left_elephant, total_flow_released, valves_already_visited)
    proper_valves = good_valves(current_me_valve, valves_already_visited, timer_left_me)
    @solutions << total_flow_released
    proper_valves.each do |valve|
      new_visited_valves = valves_already_visited.clone << valve
      new_timer = timer_left_me - (current_me_valve.get_distance_to_valve(valve) + 1)
      total_flow = total_flow_released + (valve.flow_rate * new_timer)
      visit_child_valve(valve, current_elephant_valve,new_timer, timer_left_elephant, total_flow, new_visited_valves)
    end
  end

  def process
    (0..1).each do |i|
      @relevant_valves.each do |valve|
        puts "#{valve.name}, #{i}"
        dist_tot_valve = fetch_valve('AA').get_distance_to_valve(valve)+1
        visit_child_valve(valve, fetch_valve('AA'), 26-dist_tot_valve, 26, (26-dist_tot_valve)*valve.flow_rate,[valve]) if i == 0
        visit_child_valve(fetch_valve('AA'), valve, 26, 26-dist_tot_valve,(26-dist_tot_valve)*valve.flow_rate,[valve]) if i == 1
      end
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

exercise = Day16B.new
exercise.process
exercise.print_answer
