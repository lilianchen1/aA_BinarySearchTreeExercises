require 'byebug'

class PolyTreeNode

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def add_child(child)
    @children << child unless @children.include? child
    child.parent = self unless child.parent == self
  end

  def parent=(node_parent)
    unless node_parent == @parent
      old_parent = @parent
      @parent = node_parent
    end
    if !@parent.nil?
      if !@parent.children.include?(self)
        @parent.add_child(self)
      end
    end
    if !old_parent.nil? && old_parent.children.include?(self)
      old_parent.remove_child(self)
    end
  end

  def remove_child(child)
    raise "Not a child" unless @children.include?(child)
    @children.delete(child)
    child.parent = nil unless child.parent != self
  end

  def dfs(target_value)
    return self if self.value == target_value
    self.children.each do |child|
      search = child.dfs(target_value)
      return search unless search.nil?
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      node = queue.shift
      return node if node.value == target_value
      queue += node.children
    end
    nil
  end
end
