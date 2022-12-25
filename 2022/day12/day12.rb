#!/usr/bin/env ruby

require 'rspec/autorun'
require 'pry'

EXAMPLE_INPUT = <<~INPUT.freeze
  Sabqponm
  abcryxxl
  accszExk
  acctuvwj
  abdefghi
INPUT


class HeightMap
  attr_accessor :map, :start, :end
  def initialize(input, s_char, e_char)
    @map = input.split("\n").map.with_index {|r, xidx| r.chars.each_with_index{ |c, yidx| {x: xidx, y: yidx, value: c }}}
    @start = s_char
    @end = e_char

    #@root = find_start
  end

  # def find_start(map)
  #   map.each_with_index do |row, xidx|
  #     row.each_with_index do |col, yidx|
  #       return xidx, yidx if map[xidx][yidx] == 'S'
  #     end
  #   end
  # end
  
  # def visited?(x, y)
  #   visited["#{x},#{y}"]
  # end
  
  # def visit(x,y)
  #   @visited["#{x},#{y}"] = true
  # end
  
  # def neighbors(x, y)
  #   n = []
  #   n << map[x-1, y] if (x-1 < 0) && (! visited?(x-1, y))
  #   n << map[x+1, y] if (x+1 >= map[0].size) && (! visited?(x+1, y))
  #   n << map[x, y-1] if (y-1 < 0) && (! visited?(x, y-1))
  #   n << map[x, y+1] if (y+1 >= map.size) && (! visited?(x, y+1))
  
  #   binding.pry
  # end
end

def solve_part1(input)
  heightmap = HeightMap.new(EXAMPLE_INPUT, 'S', 'E')
end

def solve_part2(input)
  nil
end

def main
  input = File.read("#{__dir__}/day12.txt")

  puts solve_part1(input)
  # puts solve_part2(input)
end

main

RSpec.describe 'Day N' do
  it 'works for part 1' do
    expect(solve_part1(EXAMPLE_INPUT)).to eq(31)
  end

  it 'works for part 2' do
    expect(solve_part2(EXAMPLE_INPUT)).to eq(0)
  end
end