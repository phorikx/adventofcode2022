# frozen_string_literal: true

require 'pry'
require_relative './directory'
require_relative './file'
require_relative './command_parser'

file = File.open('input.txt')
file_data = file.read

lines = file_data.split("\n")
root_directory = Directory.new('root', nil)
command_parser = CommandParser.new(root_directory, lines)

command_parser.parse

sum = 0
puts command_parser.all_directories.size.to_s
command_parser.all_directories.each do |dir|
  dir_size = dir.get_directory_size
  sum += dir_size if dir_size <= 100_000
end

puts sum.to_s
