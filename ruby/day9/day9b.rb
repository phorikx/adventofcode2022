# frozen_string_literal: true

class Day9
  attr_accessor :positions

  def initialize
    @positions = Array.new(10) { [[0, 0]] }
    @file = File.open('input.txt').read.split("\n").map { |i| i.split(' ') }.map { |i| [i[0], i[1].to_i] }
  end

  def round_to_one(int)
    int.zero? ? 0 : int / int.abs
  end

  def read_head_position
    head_position = [0, 0]
    @file.each do |line|
      line[1].times do
        case line[0]
        when 'U'
          head_position[1] += 1
        when 'D'
          head_position[1] -= 1
        when 'L'
          head_position[0] -= 1
        when 'R'
          head_position[0] += 1
        end
        @positions[0] << head_position.clone
      end
    end
  end

  def add_tail_n_positions(n)
    tail_position = @positions[n][0]
    @positions[n - 1].each_with_index do |position, index|
      next if index.zero?

      diff_in_position = [position[0] - tail_position[0], position[1] - tail_position[1]]
      if diff_in_position.max > 1 || diff_in_position.min < -1
        tail_position[0] += round_to_one(diff_in_position[0])
        tail_position[1] += round_to_one(diff_in_position[1])
      end
      @positions[n] << tail_position.clone
    end
  end

  def print_unique_positions_for_index(n)
    puts @positions[n].uniq.length
  end
end

exercise = Day9.new
exercise.read_head_position
(1..9).each do |n|
  exercise.add_tail_n_positions(n)
end
exercise.print_unique_positions_for_index(9)
