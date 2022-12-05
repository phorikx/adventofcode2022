require 'pry'

file = File.open('input.txt')
file_data = file.read

lines = file_data.split("\n")

score_for_self = {"X" => 1, "Y" => 2, "Z" => 3}
score_for_opponent = {
  "X" => {"A" => 3, "B" => 0, "C" => 6},
  "Y" => {"A" => 6, "B" => 3, "C" => 0},
  "Z" => {"A" => 0, "B" => 6, "C" => 3}
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

