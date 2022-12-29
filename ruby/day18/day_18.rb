# frozen_string_literal: true

class Day18
  def initialize
    @file = File.read('input.txt').split("\n").map { |line| line.split(',').map(&:to_i) }
    @sides = 0
    @max_x = @file.map { |line| line[0] }.max
    @max_y = @file.map { |line| line[1] }.max
    @max_z = @file.map { |line| line[2] }.max
    @unreachable_squares = []
    @reachable_squares = [[-1, -1, -1]]
    @currently_checking = []
  end

  def process
    (0..@max_x).each do |x|
      (0..@max_y).each do |y|
        (0..@max_z).each do |z|
          determine_unreachable_position([x, y, z])
        end
      end
    end
    @file.each do |line|
      matched_faces = 0
      @reachable_squares.each do |line2|
        matched_faces += 1 if [(line[0] - line2[0]).abs, (line[1] - line2[1]).abs, (line[2] - line2[2]).abs].sum == 1
      end
      @sides += matched_faces
    end
  end

  def determine_unreachable_position(coords)
    return true if @currently_checking.include?(coords)
    @currently_checking << coords
    return true if @unreachable_squares.include?(coords)

    if @file.include?(coords)
      @unreachable_squares << coords
      @currently_checking.delete(coords)
      return true
    end
    @currently_checking << coords
    if search_path_to_origin(coords)
      @unreachable_squares << coords
      @currently_checking.delete(coords)
      return true
    end
    @reachable_squares << coords
    @currently_checking.delete(coords)
    false
  end

  def search_path_to_origin(coords)
    neighbors = []
    neighbors << [coords[0] - 1, coords[1], coords[2]] if coords[0] >= 0
    neighbors << [coords[0] + 1, coords[1], coords[2]] if coords[0] <= @max_x
    neighbors << [coords[0], coords[1] - 1, coords[2]] if coords[1] >= 0
    neighbors << [coords[0], coords[1] + 1, coords[2]] if coords[1] <= @max_y
    neighbors << [coords[0], coords[1], coords[2] - 1] if coords[2] >= 0
    neighbors << [coords[0], coords[1], coords[2] + 1] if coords[2] <= @max_z
    neighbors.all? do |neighbor| 
      determine_unreachable_position(neighbor) 
    end
  end

  def print_answer
  end

  def visit_child_valve 
  end
end

exercise = Day18.new
exercise.process
exercise.print_answer
