# frozen_string_literal: true

require 'pry'

file = File.open('input.txt')
file_data = file.read

lines = file_data.split("\n")
lines = lines.map { |line| line.split(',') }
lines = lines.map { |line| line.map { |pair| pair.split('-') } }
lines = lines.map { |line| line.map { |pair| pair.map(&:to_i) } }
filtered_lines = lines.filter do |line|
  line[0][1] < line[1][0] || line[0][0] > line [1][1]
end

puts 1000 - filtered_lines.count
