#! /usr/bin/ruby

require 'securerandom'
require 'pry'

input = <<-INPUT
$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k
INPUT

input = File.read('day07.txt')
def directory_size(dir)
  Dir.glob(File.join(dir, '**', '**')).select{ |f| File.file?(f)}.map{|f| File.size(f)}.inject(:+)
end

root_path = Dir.pwd
unless File.directory?('day07')
  Dir.mkdir("#{root_path}/day07")
end
ROOT_PATH = root_path + '/day07'
path = ROOT_PATH

input.split("\n").each do |command|
  case command
  when /\$ cd \//
    path = ROOT_PATH
  when /\$ ls/
    # do nothing
  when /dir (\S+)/
    Dir.mkdir("#{path}/#{$1}") unless File.directory?("#{path}/#{$1}")
  when /(\d+) (\S+)/
    size = $1.to_i
    name = $2
    File.open("#{path}/#{$2}", 'wb') do |f|
      f.write( SecureRandom.random_bytes( $1.to_i ) )
    end
  when /cd \.\./
    path = path.gsub(/\/\w+$/, '')
  when /\$ cd (\S+)/
    path = "#{path}/#{$1}"
  else
  end
end

directories = Dir.glob('**/*').select {|f| File.directory? f}

small_dirs =  directories.each.inject(0) do |sum, dir|
  if directory_size(dir) < 100_000
    p "#{dir} SIZE: #{directory_size(dir)}"
    sum += directory_size(dir)
  else
    sum += 0
  end
end

p "Small dirs: #{small_dirs}"

root_size = directory_size(ROOT_PATH)
space = 70_000_000
free_space = space - root_size
needed_space = 30_000_000 - free_space

directory_to_remove = directories.map{|d| directory_size(d)}.reject{|s| s < needed_space}.min
p "smallest to remove:  #{directories.map{|d| directory_size(d)}.reject{|s| s < needed_space}.min}"
