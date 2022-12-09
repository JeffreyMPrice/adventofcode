#! /usr/bin/ruby

require 'pry'

class Point
  attr_accessor :x, :y

  def initialize(a, b)
    @x = a
    @y = b
  end

  def move(direction)
    case direction
    when 'R'
      @x += 1
    when 'L'
      @x -= 1
    when 'U'
      @y += 1
    when 'D'
      @y -= 1
    end
    p "Move to (#{x},#{y})"
  end

  def chase(head)
    if ! cover?(head) && ! adjacent?(head)
      a, b = distance_to(head)
      a, b = find_planck_movement(a,b)
      @x += a
      @y += b
    end
    p "Chase to (#{x},#{y})"
  end

  def find_planck_movement(a,b)
    a = a/2 if a.abs == 2
    b = b/2 if b.abs == 2
    return a,b
  end

  def distance_to(point)
    return point.x - x, point.y - y
  end

  def cover?(point)
    x == point.x && y == point.y
  end

  def adjacent?(point)
    (x - point.x).abs <= 1 && (y - point.y).abs <= 1 && ! cover?(point)
  end

  def diagonal?(point)
    x != point.x && y != point.y
  end

  def to_s
    "#{x}:#{y}"
  end
end

input = <<-INPUT
R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2
INPUT

input = <<-INPUT
R 5
U 8
L 8
D 3
R 17
D 10
L 25
U 20
INPUT

input = File.read('day09.txt')

# part 1
POSITIONS = {}
head = Point.new(0,0)
tail = Point.new(0,0)

input.split("\n").each do |move|
  direction, distance = move.match(/(\w) (\d+)/).captures
  p move
  distance.to_i.times do |_|
    head.move(direction)
    tail.chase(head)
    POSITIONS[tail.to_s] = 1
  end
end

p "distinct locations Part 1: #{POSITIONS.size}"

# part 2
POSITIONS = {}
head = Point.new(0,0)
knots = Array.new(9) { |i| Point.new(0,0) }

input.split("\n").each do |move|
  direction, distance = move.match(/(\w) (\d+)/).captures
  p move
  distance.to_i.times do |_|
    head.move(direction)
    leader = head
    knots.each do |k|
      k.chase(leader)
      leader = k
    end
    POSITIONS[knots.last.to_s] = 1
  end
end

p "distinct locations Part 2: #{POSITIONS.size}"
