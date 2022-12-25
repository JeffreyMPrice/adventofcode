DEBUG = false
def visible?(x,y,matrix)
  tree = matrix[x][y]
  x_length = matrix.size - 1
  y_length = matrix[0].size - 1
  row = matrix[x]
  col = matrix.transpose[y]
  return true if exterior_tree?(x,y,matrix)
  interior = (tree > row[0..y-1].max || tree > row[y+1..y_length].max || tree > col[0..x-1].max || tree > col[x+1..x_length].max)
  if DEBUG
    p "tree cords: #{x},#{y}"
    p "tree height: #{tree}"
    p "x_length"
    p "tree cords: #{x},#{y}"
    p "tree height: #{tree}"
    p "tree row: #{row}"
    p "tree col: #{col}"
    p "tree left: #{row[0..y-1]}"
    p "tree visible: #{tree > row[0..y-1].max}"
    p "tree right: #{row[y+1..y_length]}"
    p "tree visible: #{tree > row[y+1..y_length].max}"
    p "tree up: #{col[0..x-1]}"
    p "tree visible: #{tree > col[0..x-1].max}"
    p "tree down: #{col[x+1..x_length]}"
    p "tree visible: #{tree > col[x+1..x_length].max}"
    p "visible? #{interior}"
  end

  return interior
end

def exterior_tree?(x,y,matrix)
  (x == 0 || y == 0 || x == matrix.size-1 || y == matrix[0].size-1)
end

def scenic_score(x,y,matrix)
  return 0 if exterior_tree?(x,y,matrix)

  tree = matrix[x][y]
  x_length = matrix.size - 1
  y_length = matrix[0].size - 1
  row = matrix[x]
  col = matrix.transpose[y]
  left = direction_score(tree, row[0..y-1].reverse)
  p "  direction left(#{row[0..y-1].reverse}) = #{left}"
  right = direction_score(tree,row[y+1..y_length])
  p "  direction right(#{row[y+1..y_length]}) = #{right}"
  up = direction_score(tree,col[0..x-1].reverse)
  p "  direction up(#{col[0..x-1].reverse}) = #{up}"
  down = direction_score(tree,col[x+1..x_length])
  p "  direction down(#{col[x+1..x_length]}) = #{down}"
  return left * right * up * down
end

def direction_score(tree, direction)
  score = 0
  direction.each do |t|
    score += 1 if t < tree
    return score+1 if t >= tree
  end
  score
end
input = <<-WOT
30373
25512
65332
33549
35390
WOT

input = File.read('day08.txt')

forest = input.split("\n").map{ |l| l.chars }

sum = 0
p forest
p '----------------------'
forest.each_with_index do |trees, xidx|
  trees.each_with_index do |tree, yidx|
    sum += 1 if visible?(xidx, yidx, forest)
  end
end
p sum

max = 0
p forest
p '----------------------'
forest.each_with_index do |trees, xidx|
  trees.each_with_index do |tree, yidx|
    p "processing tree: (#{xidx},#{yidx}) = #{tree}"
    ss = scenic_score( xidx, yidx, forest)
    p "tree(#{xidx},#{yidx}) = #{ss}"
    max = ss if ss > max
  end
end
p max

