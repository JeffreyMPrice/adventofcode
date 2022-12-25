#! /usr/bin/ruby

require 'pry'
require 'active_support/all'

CHUNK_SIZE = 4

input = File.read('day06.txt').chars

i = CHUNK_SIZE
input.each_cons(CHUNK_SIZE) do |marker|
  break if marker.uniq.length == CHUNK_SIZE
  i = i+1
end
p "solution is #{i}"

