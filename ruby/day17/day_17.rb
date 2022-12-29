class Day17
  attr_accessor :grid, :highest_rock
  
  class Flat
    def initialize(highest_rock)
      puts grid.inspect
      @center = [highest_rock + 4,2]
    end

  end

  class Plus
    def initialize(highest_rock)
      @center = [highest_rock + 5,3]
    end
  end

  class Corner 
    def initialize(highest_rock)
      @center = [highest_rock + 4,4]
    end
  end

  class I
    def initialize(highest_rock)
      @center = [highest_rock + 4,2]
    end
  end

  class Square
    def initialize(highest_rock)
      @center = [highest_rock + 4,2]
    end
  end

  def initialize
    @highest_rock = 0
    @classes = [Flat, Plus, Corner, I, Square]
    @wind = File.read('input.txt').split("")
    @grid = []
  end

  def process
    total_rocks = 0
    while total_rocks < 2023
      total_rocks += 1
      shape = @classes.shift
      @classes.push(shape)
      block = shape.new(highest_rock)

    end
  end

  def print_answer
    puts @highest_rock
  end
end

exercise = Day17.new
exercise.process
exercise.print_answer