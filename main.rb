# Node class
class Node
  include Comparable

  def initialize(data = nil, left_children = nil, right_children = nil)
    @data = data
    @left_children = left_children
    @right_children = right_children
  end
end

# Tree class
class Tree
  def initialize(arr)
    @arr = arr
    @root = build_tree
  end

  def build_tree

  end
end

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
p tree
