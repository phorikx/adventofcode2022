# frozen_string_literal: true

class Monkey
  attr_accessor :inspected_items, :items, :divisible_by

  def initialize(data)
    lines = data.split("\n")
    @inspected_items = 0
    @items = lines[1].split(': ')[1].split(', ').map(&:to_i)
    @operation = lines[2].split('= ')[1]
    @divisible_by = lines[3].split('by ')[1].to_i
    @monkey_targets = [lines[4].split('monkey ')[1].to_i, lines[5].split('monkey ')[1].to_i]
  end

  def operation(old)
    eval(@operation)
  end

  def test?(priority)
    (priority % @divisible_by).zero?
  end

  def take_turn
    while items.length > 0
      item = items.shift
      item = operation(item)
      item = item % @filter_out
      @inspected_items += 1
      test?(item) ? @monkeys[@monkey_targets[0]].throw(item) : @monkeys[@monkey_targets[1]].throw(item)
    end
  end

  def set_monkeys(monkeys)
    @monkeys = monkeys
    @filter_out = monkeys.inject(1){|pr, monkey| pr * monkey.divisible_by}
  end

  def throw(item)
    @items.push(item)
  end
end
