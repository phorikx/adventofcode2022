# frozen_string_literal: true

require 'pry'

tree_strings = File.open('input.txt').read.split("\n").map { |line| line.split('') }
trees = tree_strings.map { |line| line.map(&:to_i) }

highest_scenic_score = 0
trees.each_with_index do |line, i|
  line.each_with_index do |tree, j|
    left_j = j
    left_j -= 1 while left_j.positive? && ((trees[i][left_j] < tree) || (left_j == j))
    right_j = j
    right_j += 1 while (right_j < trees[0].count - 1) && ((trees[i][right_j] < tree) || (right_j == j))
    up_i = i
    up_i -= 1 while up_i.positive? && ((trees[up_i][j] < tree) || (up_i == i))
    down_i = i
    down_i += 1 while (down_i < trees.count - 1) && ((trees[down_i][j] < tree) || (down_i == i))
    scenic_score = (j - left_j) * (right_j - j) * (i - up_i) * (down_i - i)
    next unless scenic_score > highest_scenic_score

    highest_scenic_score = scenic_score
    puts "#{i}, #{j}, #{tree}"
    puts "#{up_i}, #{down_i}, #{left_j}, #{right_j}"
  end
end
puts highest_scenic_score
