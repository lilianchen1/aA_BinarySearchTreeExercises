# Intro to Algorithms and Data Structure

### Design logic

1. Knights Travail:
  * Given a starting position and an ending position, the program returns the shortest path from starting position to ending position that a knight (in chess game) can travel.
  * A move tree is built upon initialization. Values in the tree are positions. A parent is connected to a child if the knight can move from the parent position to the child position. The root of the tree is the knight's starting position. Instances of the class PolyTreeNode are used to represent each position.
  
2. PolyNodeTree class
  * Each class represents a node in a search tree
  * Instance methods include:
    * Parent setter/getter
    * Children and value getters
    * Adding children/removing children
    * Depth First Search
    * Breadth First Search
    
### Running the code

1. Open irb or pry in the terminal
2. `require "./knights.rb"`
3. Create a new instance of the Knight class with a starting position. `k = KnightPathFinder.new([0, 0])`
4. Run `k.find_path([7, 6])` or any ending position of your choosing
