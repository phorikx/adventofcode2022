# frozen_string_literal: true

class Day10
  attr_accessor :positions

  def initialize
    @file = File.open('input.txt').read.split("\n")
    @register = 1
    @values = [1, 1]
  end

  def run_lines
    @file.each do |line|
      case line
      when /noop/
        @values << @register
      when /addx (-?)(\d*)/
        @values << @register
        value = Regexp.last_match(2).to_i
        @register = Regexp.last_match(1) == '' ? @register + value : @register - value
        @values << @register
      end
    end
  end

  def calculate_answer
    @sum = 0
    k = 20
    while k < @values.length
      @sum += k * @values[k]
      puts @sum
      k += 40
    end
  end

  def print_answer
    puts @sum
    print_screen
  end

  def print_screen
    (0..5).each do |i|
      (1..40).each do |k|
        register_value = @values[k + 40 * i]
        if (k - 1 - register_value).abs <= 1
          print('#')
        else
          print(' ')
        end
      end
      print("\n")
    end
  end
end

exercise = Day10.new
exercise.run_lines
exercise.calculate_answer
exercise.print_answer
