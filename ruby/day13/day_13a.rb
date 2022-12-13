# frozen_string_literal: true

class Day13
  attr_accessor :nodes

  def initialize
    file = File.read('input.txt').split("\n\n").map { |pair| pair.split("\n") }
    @pairs = file.map { |pair| [eval(pair[0]), eval(pair[1])] }
  end

  def process
    @sum = 0
    @pairs.each_with_index do |pair, i|
      @sum += i + 1 if compare_lists(pair[0], pair[1])[1]
    end
  end

  def compare_entries(a, b)
    if is_int?(a) && is_int?(b)
      compare_integers(a, b)
    else
      compare_lists(*convert_to_lists(a, b))
    end
  end

  def compare_integers(a, b)
    return [false] if a == b

    [true, a < b]
  end

  def convert_to_lists(a, b)
    a = is_int?(a) ? [a] : a
    b = is_int?(b) ? [b] : b
    [a, b]
  end

  def compare_lists(a, b)
    to_check = [a.length, b.length].min - 1
    (0..to_check).each do |i|
      comparison = compare_entries(a[i], b[i])
      return [true, comparison[1]] if comparison[0]
    end
    return [true, a.length < b.length] unless a.length == b.length

    [false]
  end

  def print_answer
    puts @sum
  end

  def is_int?(a)
    !!begin
      a.to_i
    rescue StandardError
      false
    end
  end
end

exercise = Day13.new
exercise.process
exercise.print_answer
