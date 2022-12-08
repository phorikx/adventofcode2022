# frozen_string_literal: true

require 'pry'

tree_strings = File.open('input.txt').read.split("\n").map { |line| line.split('') }
trees = tree_strings.map do |line|
  line.map do |tree|
    [tree.to_i]
  end
end

trees.map do |line|
  tallest_length = -1
  line.map do |tree|
    if tree[0] > tallest_length
      tree << 'x'
      tallest_length = tree[0]
    end
  end
end

trees.map do |line|
  tallest_length = -1
  line.reverse_each.map do |tree|
    if tree[0] > tallest_length
      tree << 'x'
      tallest_length = tree[0]
    end
  end
end

(0..trees[0].length - 1).each do |i|
  tallest_length = -1
  (0..trees.length - 1).each do |j|
    if trees[j][i][0] > tallest_length
      trees[j][i] << 'x'
      tallest_length = trees[j][i][0]
    end
  end
end

(0..trees.length - 1).each do |i|
  tallest_length = -1
  (0..(trees.length - 1)).to_a.reverse.each do |j|
    if trees[j][i][0] > tallest_length
      trees[j][i] << 'x'
      tallest_length = trees[j][i][0]
    end
  end
end

puts trees.inject(0) { |sum, line| sum + line.select { |tree| tree.count > 1 }.count }
