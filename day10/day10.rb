class Tick
    attr_reader :before, :during, :after

    def initialize(b, d, a)
        @before = b
        @during = d
        @after = a
    end

    def to_s
        "Tick: before: #{before} // during: #{during} // after: #{after}"
    end
end

def sprite(i)
    (i-1..i+1)
end
input = <<-INPUT
noop
addx 3
addx -5
INPUT

input = <<-INPUT
addx 15
addx -11
addx 6
addx -3
addx 5
addx -1
addx -8
addx 13
addx 4
noop
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx -35
addx 1
addx 24
addx -19
addx 1
addx 16
addx -11
noop
noop
addx 21
addx -15
noop
noop
addx -3
addx 9
addx 1
addx -3
addx 8
addx 1
addx 5
noop
noop
noop
noop
noop
addx -36
noop
addx 1
addx 7
noop
noop
noop
addx 2
addx 6
noop
noop
noop
noop
noop
addx 1
noop
noop
addx 7
addx 1
noop
addx -13
addx 13
addx 7
noop
addx 1
addx -33
noop
noop
noop
addx 2
noop
noop
noop
addx 8
noop
addx -1
addx 2
addx 1
noop
addx 17
addx -9
addx 1
addx 1
addx -3
addx 11
noop
noop
addx 1
noop
addx 1
noop
noop
addx -13
addx -19
addx 1
addx 3
addx 26
addx -30
addx 12
addx -1
addx 3
addx 1
noop
noop
noop
addx -9
addx 18
addx 1
addx 2
noop
noop
addx 9
noop
noop
noop
addx -1
addx 2
addx -37
addx 1
addx 3
noop
addx 15
addx -21
addx 22
addx -6
addx 1
noop
addx 2
addx 1
noop
addx -10
noop
noop
addx 20
addx 1
addx 2
addx 2
addx -6
addx -11
noop
noop
noop
INPUT

input = File.read('day10.txt')

x_reg = [Tick.new(1,1,1)]
i = 1
input.split("\n").each do |op|
    p op
    case op
    when /noop/
        prev_tick = x_reg[i-1] 
        x_reg[i] = Tick.new(prev_tick.after,prev_tick.after,prev_tick.after)
        i += 1
    when /addx (.?\d+)/
        prev_tick = x_reg[i-1] 
        x_reg[i] = Tick.new(prev_tick.after,prev_tick.after,prev_tick.after)
        i += 1
        x_reg[i] = Tick.new(prev_tick.after,prev_tick.after,prev_tick.after + $1.to_i)
        i += 1
    end
end

sum = 0
(20..x_reg.size).step(40) do |x|
     sum += (x * x_reg[x].during)
end

p "sum part 1: #{sum}"

p x_reg.size
(1..x_reg.size).each_slice(40).with_index do |line, lidx|
    line.each_with_index do |pixel, pidx|
        i = lidx*40 + pidx + 1
        print sprite(pidx).cover?(x_reg[i].during) ? '#' : '.'
    end
    print "\n"
end