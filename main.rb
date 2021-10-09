require 'pry-byebug'

# Node class
class Node
  include Comparable
  attr_accessor :data, :left_children, :right_children

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
    if arr.size == 1
      root = Node.new(arr[0])
    elsif arr.empty?
      return nil
    else
      # get the middle of the array and make it the root
      mid = arr[arr.size / 2]
      root = Node.new(mid)
      # recursively, do the same for the left half and right half
      root.left_children = build_tree(arr[0...(arr.size / 2)])
      root.right_children = build_tree(arr[(arr.size / 2 + 1)..])
    end
    # return the level-0 root node
    return root
  end
end

binding.pry

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
puts tree.arr.join(', ')
p tree.root.left_children
