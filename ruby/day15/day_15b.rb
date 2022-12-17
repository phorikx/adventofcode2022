# frozen_string_literal: true

class Day15B
  attr_accessor :free_positions

  def initialize
    file = File.read('input.txt').split("\n")
    @observations = file.map do |line|
      line.match(/.*x=(.*), y=(.*):.*x=(.*), y=(.*)/)
      [[Regexp.last_match(1).to_i, Regexp.last_match(2).to_i], [Regexp.last_match(3).to_i, Regexp.last_match(4).to_i]]
    end
    @max_coord = 4_000_000
  end

  def process
    @observations.each do |observation|
      horizontal_distance = (observation[0][0] - observation[1][0]).abs
      vertical_distance = (observation[0][1] - observation[1][1]).abs
      total_distance = vertical_distance + horizontal_distance
      observation << total_distance
    end
    @observations.each do |observation|
      (0..observation[2]+1).each do |dist_h|
        dist_v = observation[2] + 1 - dist_h
        puts "#{@max_coord*(observation[0][0] + dist_v) + observation[0][1]+dist_h}" if test_coord(observation[0][0] + dist_v, observation[0][1]+dist_h)
        puts "#{@max_coord*(observation[0][0] - dist_v) + observation[0][1]+dist_h}" if test_coord(observation[0][0] - dist_v, observation[0][1]+dist_h)
        puts "#{@max_coord*(observation[0][0] + dist_v) + observation[0][1]-dist_h}" if test_coord(observation[0][0] + dist_v, observation[0][1]-dist_h)
        puts "#{@max_coord*(observation[0][0] - dist_v) + observation[0][1]-dist_h}" if test_coord(observation[0][0] - dist_v, observation[0][1]-dist_h)
      end
    end
  end

  def test_coord(x,y)
    @observations.all? do |observation|
      (x-observation[0][0]).abs + (y-observation[0][1]).abs > observation[2] && x >= 0 && x <= @max_coord && y>= 0 && y <= @max_coord
    end
  end
end

exercise = Day15B.new
exercise.process
