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

minimum_size = (root_directory.get_directory_size - 40_000_000)
current_candidate = root_directory
command_parser.all_directories.each do |dir|
  dif_to_min = dir.get_directory_size - minimum_size
  current_candidate = dir if dif_to_min >= 0 and current_candidate.get_directory_size > dir.get_directory_size
end

puts current_candidate.get_directory_size
