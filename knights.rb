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
    queue = []
    queue << self
    until queue.empty?
      node = queue.shift
      return node if node.value == target_value
      queue += node.children
      # queue.shift
    end
    nil
  end

  def trace_path_back
    path = []
    return [self.value] if self.parent.nil?
    # return self.value
    path += self.parent.trace_path_back << self.value
  end

end

class KnightPathFinder
  def initialize(starting_position)
    @starting_position = starting_position
    @visited_positions = [@starting_position]
    @move_tree = build_move_tree
  end

  def build_move_tree
    start = PolyTreeNode.new(@starting_position)
    queue = [start]
    until queue.empty?
      node = queue.shift
      next_possible_moves = new_move_positions(node.value)
      next_possible_moves.each do |possible_move|
        node.add_child(PolyTreeNode.new(possible_move))
      end
      queue += node.children
    end
    start #start = node and first root node of move_tree
  end

  def find_path(end_pos)
    node = @move_tree.bfs(end_pos)
    node.trace_path_back
  end

  def self.valid_moves(pos)
    move_lengths = [[-1, 2], [-1, -2], [1, 2], [1, -2]]
    x, y = pos
    potential = [].tap do |moves|
      move_lengths.each do |i|
        moves << [x + i[0], y + i[1]]
        moves << [x + i[1], y + i[0]]
      end
    end

    valid = potential.select do |pair|
      pair.none? { |i| i < 0 || i > 7 }
    end
  end

  def new_move_positions(pos)
    new_moves = self.class.valid_moves(pos).select do |pair|
      !@visited_positions.include?(pair)
    end
    @visited_positions += new_moves
    new_moves
  end


end
