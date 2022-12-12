require ('pry')

input = <<-INPUT
Monkey 0:
  Starting items: 79, 98
  Operation: new = old * 19
  Test: divisible by 23
    If true: throw to monkey 2
    If false: throw to monkey 3

Monkey 1:
  Starting items: 54, 65, 75, 74
  Operation: new = old + 6
  Test: divisible by 19
    If true: throw to monkey 2
    If false: throw to monkey 0

Monkey 2:
  Starting items: 79, 60, 97
  Operation: new = old * old
  Test: divisible by 13
    If true: throw to monkey 1
    If false: throw to monkey 3

Monkey 3:
  Starting items: 74
  Operation: new = old + 3
  Test: divisible by 17
    If true: throw to monkey 0
    If false: throw to monkey 1
INPUT


class Item
    attr_accessor :worry_level

    def initialize(wl)
        @worry_level = wl
    end
end

class Monkey
    attr_accessor :name, :items, :operation, :test, :true_monkey, :false_monkey, :inspections

    def initialize(monkey_business)
      monkey_guts = monkey_business.split("\n")

      @name = monkey_guts[0].match(/Monkey (\d+):/).captures[0]
      items_text = monkey_guts[1].match(/  Starting items: (.+)/).captures[0]
      @items = items_text.split(',').map{|i| Item.new(i.strip.to_i)}
      @operation = monkey_guts[2].match(/  Operation: (.+)/).captures[0]
      @test = monkey_guts[3].match(/  Test: divisible by (.+)/).captures[0].to_i
      @true_monkey = monkey_guts[4].match(/    If true: throw to monkey (.+)/).captures[0].to_i
      @false_monkey = monkey_guts[5].match(/    If false: throw to monkey (.+)/).captures[0].to_i
      @inspections = 0
  end

  def next_item
    @items.pop
  end

  def inspect(item)
    old = item.worry_level
    new = 0
    eval(operation)
    item.worry_level = new
    @inspections += 1
  end

end

monkeys = []

input = File.read('day11.txt')

input.split("\n\n").each_with_index do |monkey, idx|
  p "----- #{idx} -------"
  p "#{monkey}"
  monkeys[idx] = Monkey.new(monkey)
end

max_worry = 1
max_worry = monkeys.inject(1) do |mw, monkey|
  mw.lcm(monkey.test)
end

10000.times do
  monkeys.each do |m|
    items = m.items
    while( i = items.shift)
      m.inspect(i)
      i.worry_level = i.worry_level % max_worry
      next_monkey = (i.worry_level % m.test) == 0 ? m.true_monkey : m.false_monkey
      monkeys[next_monkey].items << i
    end
  end
end

p monkeys.map(&:inspections).max(2).reduce(:*)