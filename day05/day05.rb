#! /usr/bin/ruby

require 'pry'
require 'active_support/all'

def generate_board(board)
  game = Hash.new {|hsh, key| hsh[key] = [] }

  board = board.map { |lines| lines.chars }

  board.reverse!

  board.shift.each_with_index do |val, index|
    unless val.eql? ' '
      board.each do |row|
        game[val] << row[index] if (row[index].present?)
      end
    end
  end
  game
end

input = File.readlines('day05.txt', chomp: true)

board, instructions = input.split('')

input = File.read("#{__dir__}/day05.txt")
stacks, moves = input.split("\n\n")
stacks = stacks
           .lines
           .map { |line| line.chars.each_slice(4).map { |l| l[1] } }
binding.pry

game = generate_board(board)

instructions.each do |instruction|
  data = instruction.match(/move (\d+) from (\d+) to (\d+)/)
  count = data[1].to_i
  from = data[2]
  to = data[3]

  count.times do |move|
    game[to].push(game[from].pop)
  end
end

list = ''
game.each do |k, v|
  list << v.last
end

p list

game = generate_board(board)

instructions.each do |instruction|
  data = instruction.match(/move (\d+) from (\d+) to (\d+)/)
  count = data[1].to_i
  from = data[2]
  to = data[3]

  game[to].push(game[from].pop(count))
  game[to].flatten!
end

list = ''
game.each do |k, v|
  list << v.last
end

p list