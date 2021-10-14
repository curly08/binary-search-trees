# frozen_string_literal: true

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
    return if arr.empty? # base case

    # get the middle of the array and make it the root
    mid = arr.size / 2
    root = Node.new(arr[mid])
    # recursively, do the same for the left half and right half
    root.left = build_tree(arr[0...mid])
    root.right = build_tree(arr[(mid + 1)..-1])
    root # return the level-0 root node
  end

  # accepts a value to insert
  def insert(value, node = @root)
    if node.left.nil? && node.right.nil? # base case
      return node.right = Node.new(value) if value > node.data
      return node.left = Node.new(value) if value < node.data

      node
    elsif value > node.data
      node.right.nil? ? insert(value, node.left) : insert(value, node.right)
    elsif value < node.data
      node.left.nil? ? insert(value, node.right) : insert(value, node.left)
    else
      node
    end
  end

  # accepts a value to delete
  def delete(value, node = @root)
    # 3 base cases
    if value == node.data
      return node = nil if node.left.nil? && node.right.nil? # if node to delete is leaf, just delete it

      if node.left.nil? || node.right.nil? && !(node.left.nil? && node.right.nil?) # if node has 1 child, reassign child to parent child
        return node = node.left if node.right.nil?
        return node = node.right if node.left.nil?
      end

      unless node.left.nil? || node.right.nil? # if node has two children, node = next biggest (right, then furthest left)
        temp = node.clone
        temp = temp.right
        temp = temp.left until temp.left.nil?
        node.data = temp.data
        node.right = delete(temp.data, node.right)
      end
    elsif value > node.data
      node.right = delete(value, node.right)
    elsif value < node.data
      node.left = delete(value, node.left)
    else
      node
    end
    node
  end

  # accepts a value and returns the notde with the given value
  def find(value, node = @root)
    return node if node.nil? || value == node.data

    value > node.data ? find(value, node.right) : find(value, node.left)
  end

  # returns an array of values using breadth-first traversal and iteration
  def level_order_iteration
    queue = []
    results = []
    node = @root
    queue.push(node)
    until queue.empty?
      current = queue.first
      results.push(current.data)
      queue.push(current.left) unless current.left.nil?
      queue.push(current.right) unless current.right.nil?
      queue.shift
    end
    results
  end

  # returns an array of values using breadth-first traversal and recursion
  def level_order_recursion(node = @root, queue = [], results = [])
    results.push(node.data)
    queue.push(node.left) unless node.left.nil?
    queue.push(node.right) unless node.right.nil?
    return if queue.empty?

    level_order_recursion(queue.shift, queue, results)
    results
  end

  # returns an array of values using inorder depth-first traversal
  def inorder(node = @root, results = [])
    return results.push(node.data) if node.left.nil?

    inorder(node.left, results)
    results.push(node.data)
    inorder(node.right, results) unless node.right.nil?
    results
  end

  # returns an array of values using preorder depth-first traversal
  def preorder(node = @root, results = [])
    return results.push(node.data) if node.left.nil?

    results.push(node.data)
    preorder(node.left, results)
    preorder(node.right, results) unless node.right.nil?
    results
  end

  # returns an array of values using postorder depth-first traversal
  def postorder(node = @root, results = [])
    return results.push(node.data) if node.left.nil?

    postorder(node.left, results)
    postorder(node.right, results) unless node.right.nil?
    results.push(node.data)
    results
  end

  # accepts a node and returns its height
  def height(value)
    root = value.is_a?(Integer) ? find(value) : value
    return -1 if root.nil?

    [height(root.left), height(root.right)].max + 1
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
# tree.insert(11)
# tree.insert(-1)
# tree.pretty_print
# tree.delete(67)
# tree.delete(8)
# tree.delete(9)
# tree.delete(4)
# tree.delete(324)
# tree.pretty_print
# binding.pry
# p tree.find(6)
# p tree.find(2)
# p tree.level_order_iteration
# p tree.level_order_recursion
# p tree.inorder
# p tree.preorder
# p tree.postorder
p tree.height(8)
p tree.height(9)
