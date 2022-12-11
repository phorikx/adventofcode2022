# frozen_string_literal: true

file = File.open('input.txt').read.split("\n").map { |i| i.split(' ') }.map { |i| [i[0], i[1].to_i] }
puts file[0][1]

tail_positions = []

def round_to_one(int)
  int.zero? ? 0 : int / int.abs
end

head_position = [0, 0]
tail_position = [0, 0]
counter = 0
tail_positions << tail_position
file.each do |line|
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
    diff_in_position = [head_position[0] - tail_position[0], head_position[1] - tail_position[1]]
    if diff_in_position.max > 1 || diff_in_position.min < -1
      tail_position[0] += round_to_one(diff_in_position[0])
      tail_position[1] += round_to_one(diff_in_position[1])
    end
    tail_positions << tail_position.clone
  end
end

puts tail_positions.uniq.length
