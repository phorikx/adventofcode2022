# frozen_string_literal: true

require_relative './monkey'

class Day11B
  attr_accessor :positions, :monkeys

  def initialize
    @monkeys = []
    @file = File.open('input.txt').read.split("\n\n")
    @file.each do |monkey|
      monkeys << Monkey.new(monkey)
    end
    monkeys.each{|monkey| monkey.set_monkeys(monkeys)}
  end

  def process
    10_000.times do
      monkeys.each(&:take_turn)
    end
  end

  def print_answer
    activity = monkeys.map{|monkey| monkey.inspected_items}.sort.reverse
    puts activity.inspect
    puts activity[0]*activity[1]
  end
end

exercise = Day11B.new
exercise.process
exercise.print_answer
