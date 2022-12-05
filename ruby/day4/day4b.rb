# frozen_string_literal: true

require 'pry'

file = File.open('input.txt')
file_data = file.read

lines = file_data.split("\n")
lines = lines.map { |line| line.split(',') }
lines = lines.map { |line| line.map { |pair| pair.split('-') } }
filtered_lines = lines.filter do |line|
  line[0][1].to_i < line[1][0].to_i || line[0][0].to_i > line [1][1].to_i
end

filtered_lines.each{|line| puts line.inspect}
puts filtered_lines.count
