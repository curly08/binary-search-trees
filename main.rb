# frozen_string_literal: true

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
    node = value.is_a?(Integer) ? find(value) : value
    return -1 if node.nil?

    [height(node.left), height(node.right)].max + 1
  end

  # accepts a node and returns its depth
  def depth(value, node = @root)
    return nil if find(value).nil?
    return 0 if value == node.data

    value > node.data ? depth(value, node.right) + 1 : depth(value, node.left) + 1
  end

  # checks if the tree is balanced
  def balanced?(node = @root)
    return true if node.nil? || node.left.nil? && node.right.nil?
    return false unless (height(node.left) - height(node.right)).between?(-1, 1)

    balanced?(node.left) && balanced?(node.right)
  end

  # rebalances an unbalanced tree
  def rebalance
    return self if balanced?

    @root = build_tree(level_order_recursion.uniq.sort)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

# test script
tree = Tree.new(Array.new(15) { rand(1..100) })
tree.pretty_print
p tree.balanced?
p tree.level_order_recursion
p tree.preorder
p tree.inorder
p tree.postorder
tree.insert(rand(100..200))
tree.insert(rand(100..200))
tree.insert(rand(100..200))
tree.insert(rand(100..200))
tree.insert(rand(100..200))
tree.pretty_print
p tree.balanced?
tree.rebalance
tree.pretty_print
p tree.balanced?
p tree.level_order_recursion
p tree.preorder
p tree.inorder
p tree.postorder
