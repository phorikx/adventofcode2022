# frozen_string_literal: true

require 'pry'
file = File.open('input_test.txt')
file_data = file.read

seperated_file = file_data.split("\n\n")

stack = seperated_file[0]
stack_by_lines = stack.split("\n")
no_of_stacks = stack_by_lines[-1].strip.split('')[-1].to_i
stacks = Array.new(no_of_stacks) { [] }
beginning_stack = stack.split("\n").reverse[1..]
beginning_stack.each do |row|
  (0..no_of_stacks - 1).each do |no|
    entry_at_row = row.split('')[1 + no * 4]
    stacks[no].push(entry_at_row) unless entry_at_row =~ /\s/ or entry_at_row.nil?
  end
end

instructions = seperated_file[1].split("\n")
instructions.each do |instruction|
  match = /move (?<amount>\d*) from (?<from>\d*) to (?<to>\d*)/.match(instruction)
  help_array = []
  match['amount'].to_i.times do
    help_array.push(stacks[match['from'].to_i - 1].pop)
  end
  match['amount'].to_i.times do
    stacks[match['to'].to_i-1].push(help_array.pop)
  end
end

stacks.each do |stack|
  print stack.pop
end
