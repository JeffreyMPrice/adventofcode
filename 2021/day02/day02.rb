#!/usr/bin/env ruby

require 'rspec/autorun'
require 'pry'

EXAMPLE_INPUT = <<~INPUT.freeze
forward 5
down 5
forward 8
up 3
down 8
forward 2
INPUT

def solve_part1(input)
  x = 0
  d = 0
  aim = 0
  cmd_format = /(\w+) (\d+)/
  commands = input.split("\n").map{ |c| c.match(cmd_format).captures }

  commands.each do |c|
    case c.first
    when 'forward'
      x += c.last.to_i
    when 'down'
      d += c.last.to_i
      aim += c.last.to_i
    when 'up'
      d -= c.last.to_i
      aim -= c.last.to_i
    end
  end

  x*d
end

def solve_part2(input)
  x = 0
  d = 0
  aim = 0
  cmd_format = /(\w+) (\d+)/
  commands = input.split("\n").map{ |c| c.match(cmd_format).captures }

  commands.each do |c|
    case c.first
    when 'forward'
      x += c.last.to_i
      d += aim * c.last.to_i
    when 'down'
      aim += c.last.to_i
    when 'up'
      aim -= c.last.to_i
    end
  end

  x*d
end

def main
  input = File.read("#{__dir__}/day02.txt")

  puts solve_part1(input)
  puts solve_part2(input)
end

main

RSpec.describe 'Day N' do
  it 'works for part 1' do
    expect(solve_part1(EXAMPLE_INPUT)).to eq(150)
  end

  it 'works for part 2' do
    expect(solve_part2(EXAMPLE_INPUT)).to eq(900)
  end
end