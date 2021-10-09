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
  attr_reader :arr, :sorted_arr, :root

  def initialize(arr)
    @arr = arr
    @sorted_arr = @arr.sort.uniq
    @root = build_tree(@sorted_arr)
  end

  # takes an array of data and turns it into a balanced binary tree full of Node objects appropriately placed
  def build_tree(arr)
    if arr.empty? # base case
      return
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
  def insert(value, node = @root)
    if node.left == nil && node.right == nil # base case
      if value > node.data
        return node.right = Node.new(value)
      elsif value < node.data
        return node.left = Node.new(value)
      else
        return node
      end
    else # recurse
      if value > node.data
        node.right == nil ? insert(value, node.left) : insert(value, node.right)
      elsif value < node.data
        node.left == nil ? insert(value, node.right) : insert(value, node.left)
      else
        return
      end
    end
  end

  # accepts a value to delete
  def delete(value, node = @root)
    # until node.data == value
    #   return "#{value} does not exist!" if node.left == nil && node.right == nil && node.data != value
    #   if value > node.data
    #     node.right == nil ? node = node.left : node = node.right 
    #   else
    #     node.left == nil ? node = node.right : node = node.left
    #   end
    # end
    # if value > node.data
    #   node = 

    
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
puts tree.sorted_arr.join(', ')
tree.pretty_print
tree.insert(10)
tree.insert(11)
tree.insert(13)
tree.insert(2)

tree.pretty_print
