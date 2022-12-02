require 'pry'

file = File.open("input.txt")
file_data = file.read
elves = file_data.split("\n\n")
elves_with_numbers = elves.map do |elf|
  elf.split("\n").map{ |number| number.to_i }
end

elves_with_numbers = elves_with_numbers.map(&:sum).sort.reverse

puts elves_with_numbers[0..2].sum
