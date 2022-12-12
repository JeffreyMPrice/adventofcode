file = File.open('day01.txt')
elves = []
elf = 0
elves[elf] = 0
file.each do |line|
    line.strip!
    if line.eql? ''
        elf = elf + 1
        elves[elf] = 0
        next
    end
    elves[elf] += line.to_i
end

p elves.max(3).sum