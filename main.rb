# Node class
class Node
  include Comparable

  def initialize(data = nil, left_children = nil, right_children = nil)
    @data = data
    @left_children = left_children
    @right_children = right_children
  end
end

new_node = Node.new('cat')
p new_node
