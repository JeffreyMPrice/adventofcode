#!/usr/bin/env ruby

require 'rspec/autorun'
require 'pry'

EXAMPLE_INPUT = <<~INPUT.freeze
199
200
208
210
200
207
240
269
260
263
INPUT

def solve_part1(input)
    measurements = input.split("\n").map(&:to_i)
    increases = 0
    measurements.each_cons(2) do |m1, m2|
        increases += 1 if m2 > m1
    end
    increases
end

def solve_part2(input)
    measurements = input.split("\n").map(&:to_i)
    increases = 0
    measurements.each_cons(4) do |a, b, c, d|
      increases += 1 if (b+c+d) > (a+b+c)
    end
    increases
end

def main
  input = File.read("#{__dir__}/day01.txt")

 puts solve_part1(input)
 puts solve_part2(input)
end

main

RSpec.describe 'Day N' do
  it 'works for part 1' do
    expect(solve_part1(EXAMPLE_INPUT)).to eq(7)
  end

  it 'works for part 2' do
    expect(solve_part2(EXAMPLE_INPUT)).to eq(5)
  end
end