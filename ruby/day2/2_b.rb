require 'pry'

file = File.open('input.txt')
file_data = file.read

lines = file_data.split("\n")
puts lines[0]

score_for_self = {"X" => 0, "Y" => 3, "Z" => 6}
score_for_opponent = {
  "X" => {"A" => 3, "B" => 1, "C" => 2},
  "Y" => {"A" => 1, "B" => 2, "C" => 3},
  "Z" => {"A" => 2, "B" => 3, "C" => 1}
}

sum = 0
choices = lines.map do |line|
  line.split(" ")
end

choices.each do |choice|
  sum += score_for_self[choice[1]]
  sum += score_for_opponent[choice[1]][choice[0]]
end

puts sum

