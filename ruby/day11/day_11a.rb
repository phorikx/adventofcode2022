# frozen_string_literal: true

require_relative './monkey'

class Day11A
  attr_accessor :positions, :monkeys

  def initialize
    @monkeys = []
    @file = File.open('input.txt').read.split("\n\n")
    @file.each do |monkey|
      monkeys << Monkey.new(monkey)
    end
    monkeys.each { |monkey| monkey.set_monkeys(monkeys) }
  end

  def process
    20.times do
      monkeys.each(&:take_turn)
    end
  end

  def print_answer
    activity = monkeys.map(&:inspected_items).sort.reverse
    puts activity.inspect
    puts activity[0] * activity[1]
  end
end

exercise = Day11A.new
exercise.process
exercise.print_answer
