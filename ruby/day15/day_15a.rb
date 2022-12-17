# frozen_string_literal: true

class Day15A
  attr_accessor :free_positions

  def initialize
    file = File.read('input.txt').split("\n")
    @row_to_investigate = 2_000_000
    @observations = file.map do |line|
      line.match(/.*x=(\d+), y=(\d+):.*x=(\d+), y=(\d+)/)
      [[Regexp.last_match(1).to_i, Regexp.last_match(2).to_i], [Regexp.last_match(3).to_i, Regexp.last_match(4).to_i]]
    end
    @free_positions = []
  end

  def process
    @observations.each do |observation|
      horizontal_distance = (observation[0][0] - observation[1][0]).abs
      vertical_distance = (observation[0][1] - observation[1][1]).abs
      total_distance = vertical_distance + horizontal_distance
      hor_dif_at_2000 = total_distance - (observation[0][1] - @row_to_investigate).abs
      if hor_dif_at_2000.positive?
        @free_positions += ((observation[0][0] - hor_dif_at_2000)..(observation[0][0] + hor_dif_at_2000)).to_a
      end
      @free_positions = @free_positions.uniq
    end
    @observations.each do |observation|
      @free_positions.delete(observation[1][0]) if observation[1][1] == @row_to_investigate
    end
  end

  def print_answer
    puts @free_positions.length
  end
end

exercise = Day15A.new
exercise.process
exercise.print_answer
