
class Day10
  attr_accessor :positions

  def initialize
    @file = File.open('input.txt').read.split("\n")
    @register = 1
    @values = [1,1]
  end

  def run_lines
    @file.each do |line|
      case line
      when /noop/
        @values << @register
      when /addx (-?)(\d*)/
        @values << @register
        value = $2.to_i
        @register = $1== "" ?  @register + value : @register - value
        @values << @register
      end
    end
  end

  def calculate_answer
    @sum = 0
    k = 20
    while k < @values.length
      @sum += k*@values[k]
      puts @sum
      k+=40
    end
  end

  def print_answer
    puts @values.length
    puts @values.inspect
    puts @sum
  end
end

exercise = Day10.new
exercise.run_lines
exercise.calculate_answer
exercise.print_answer 
