# frozen_string_literal: true

require 'pry'
file = File.open('input.txt')
file_data = file.read

latest_chars = []
file_data.split('').each_with_index do |char, index|
  latest_chars << char
  latest_chars.shift if latest_chars.length > 4
  if (latest_chars.length == 4) && (latest_chars.uniq.length == 4)
    puts index + 1
    break
  end
end
