# frozen_string_literal: true

require 'pry'

file = File.open('input.txt')
file_data = file.read

lines = file_data.split("\n")
sum = 0
lines.each do |line|
  first_half = line[0,line.length/2]
  second_half = line[line.length/2,line.length]
  first_array = first_half.split("").uniq
  second_array = second_half.split("").uniq
  new_line = first_array + second_array
  repeat_character = new_line.filter{|c| new_line.count(c) > 1}[0]
  puts repeat_character
  sum += if repeat_character.ord > 95
           repeat_character.ord - 96
         else
           repeat_character.ord - 38
         end
end
puts sum
