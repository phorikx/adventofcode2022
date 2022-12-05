# frozen_string_literal: true

require 'pry'

file = File.open('input_test.txt')
file_data = file.read

lines = file_data.split("\n")
sum = 0
lines.each_slice(3) do |a,b,c|
  all_chars = a.split("").uniq + b.split("").uniq + c.split("").uniq
  repeat_character = all_chars.filter{|c| all_chars.count(c) > 2}[0]
  puts repeat_character
  sum += if repeat_character.ord > 95
           repeat_character.ord - 96
         else
           repeat_character.ord - 38
         end
end
puts sum
