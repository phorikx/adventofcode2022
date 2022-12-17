# frozen_string_literal: true

class Day13
  attr_accessor :packets

  def initialize
    @packets = File.read('input.txt').split("\n").map { |packet| eval(packet) }.compact
    @packets << [[2]]
    @packets << [[6]]
  end

  def process
    sorted = false
    until sorted
      sorted = true
      (1..@packets.length - 1).each do |i|
        next if compare_packets(@packets[i - 1], packets[i])

        sorted = false
        store = packets[i - 1]
        packets[i - 1] = packets[i]
        packets[i] = store
      end
    end
  end

  def compare_packets(a, b)
    compare_entries(a, b)[1]
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
    puts (@packets.find_index([[2]]) + 1) * (@packets.find_index([[6]]) + 1)
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
