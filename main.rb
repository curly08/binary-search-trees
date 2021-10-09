require 'pry-byebug'

# Node class
class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data = nil)
    @data = data
    @left = nil
    @right = nil
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
    if arr.empty?
      return nil
    else
      # get the middle of the array and make it the root
      mid = arr.size / 2
      root = Node.new(arr[mid])
      # recursively, do the same for the left half and right half
      root.left = build_tree(arr[0...mid])
      root.right = build_tree(arr[(mid + 1)..])
    end
    # return the level-0 root node
    return root
  end

  # accepts a value to insert
  def insert(value)
    node = @root
    until node.left == nil && node.right == nil
      if value > node.data
        node.right == nil ? node = node.left : node = node.right 
      elsif value < node.data
        node.left == nil ? node = node.right : node = node.left
      else
        return
      end
    end

    if value > node.data
      node.right = Node.new(value)
    elsif value < node.data
      node.left = Node.new(value)
    end
  end

  # accepts a value to delete

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
puts tree.arr.join(', ')
tree.pretty_print

tree.insert(2)
# binding.pry

tree.insert(33)
tree.insert(12)
tree.insert(323)
tree.insert(3)

tree.pretty_print

