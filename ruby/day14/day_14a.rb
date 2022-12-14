# frozen_string_literal: true

class Day14A
  attr_accessor :rocks, :grid, :offset

  def initialize
    @rocks = File.read('input.txt').split("\n").map do |pair|
               pair.split(' -> ')
             end.map do |pairs|
      pairs.map do |pair|
        pair.split(',').map(&:to_i)
      end
    end
    @min_left = 10_000
    @max_right = 0
    @no_of_rows = 0
    rocks.each do |row|
      row.each do |rock|
        @min_left = rock[0] if rock[0] < @min_left
        @max_right = rock[0] if rock[0] > @max_right
        @no_of_rows = rock[1] if rock[1] > @no_of_rows
      end
    end
    @offset = @min_left - 1
    @no_of_cols = @max_right - @offset + 1
    @grid = Array.new(@no_of_rows + 2) { Array.new(@no_of_cols) { 0 } }
    @rocks.each do |rock_path|
      (1..rock_path.length - 1).each do |i|
        fill_path_with_rocks(rock_path[i - 1], rock_path[i])
      end
    end
  end

  def process
    @total_units = 0
    max_y_index = 0
    current_position = [0, 500 - offset]
    while max_y_index < @no_of_rows
      if (@grid[current_position[0] + 1][current_position[1]]).zero?
        current_position[0] += 1
        max_y_index = [current_position[0], max_y_index].max
      elsif (@grid[current_position[0] + 1][current_position[1] - 1]).zero?
        current_position[0] += 1
        current_position[1] -= 1
        max_y_index = [current_position[0], max_y_index].max
      elsif (@grid[current_position[0] + 1][current_position[1] + 1]).zero?
        current_position[0] += 1
        current_position[1] += 1
        max_y_index = [current_position[0], max_y_index].max
      else
        @grid[current_position[0]][current_position[1]] = 2
        current_position = [0, 500 - offset]
        @total_units += 1
      end
    end
  end

  def fill_path_with_rocks(a, b)
    first_range = ([a[1], b[1]].min)..([a[1], b[1]].max)
    second_range = ([a[0], b[0]].min - offset)..([a[0], b[0]].max - offset)
    first_range.each do |i|
      second_range.each do |j|
        @grid[i][j] = 1
      end
    end
  end

  def print_answer
    print_grid
    puts @total_units
  end

  def print_grid
    @grid.each do |row|
      row.each do |spot|
        print ' ' if spot.zero?
        print '#' if spot == 1
        print 'O' if spot == 2
      end
      print "\n"
    end
  end
end

exercise = Day14A.new
exercise.process
exercise.print_answer
