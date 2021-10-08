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
  attr_reader :arr, :root

  def initialize(arr)
    @arr = arr.sort.uniq
    @root = build_tree(@arr)
  end

  # takes an array of data and turns it into a balanced binary tree full of Node objects appropriately placed
  def build_tree(arr)
    # base case
    
    # get the middle of the array and make it the root
    root = arr[arr.size / 2]
    # recursively, do the same for the left half and right half


    # return the level-0 root node
    return root
  end
end

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
p tree
