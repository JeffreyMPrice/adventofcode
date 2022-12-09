#! /usr/bin/ruby

require 'pry'

SCORES = { A: { X: 1+3, Y: 2+6, Z: 3+0},
           B: { X: 1+0, Y: 2+3, Z: 3+6},
           C: { X: 1+6, Y: 2+0, Z: 3+3} }

SCORES_2 = { A: { X: 3+0, Y: 1+3, Z: 2+6},
             B: { X: 1+0, Y: 2+3, Z: 3+6},
             C: { X: 2+0, Y: 3+3, Z: 1+6} }
guide = File.open("day02.txt").readlines

score = 0
guide.each do |round|
  their_move, our_move = round.split(' ')
  score += SCORES_2[their_move.to_sym][our_move.to_sym]
end

p score