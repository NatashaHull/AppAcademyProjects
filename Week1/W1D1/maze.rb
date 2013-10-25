require 'set'

maze = []
maze_start = []
maze_end = []
current_coord = [0,0]
#filename = gets.chomp
filename = "maze1.txt"
File.readlines(filename).each do |line|
  result = []
  row = line.chomp
  row.split('').each do |symbol|
    case symbol
    when " "
      result << true
    when "S"
      maze_start = [current_coord[0], current_coord[1]]
      result << true
    when "E"
      maze_end = [current_coord[0], current_coord[1]]
      result << true
    when "*"
      result << false
    else
      result << false
    end
    current_coord[1] += 1
  end
  maze << result
  current_coord = [current_coord[0] + 1, 0]
end

##
maze.each do |arr|
  p arr
end
p maze_start
p maze_end
##

#A*
def manhattan(current, goal)
  x = current[0] - goal[0]
  y = current[1] - goal[1]
  x.abs + y.abs
end

def a_star_search(start_position, maze, maze_end)
  closed_set = Set.new [start_position]
  open_list = open_spaces(maze)
  frontier = [start_position]
  paths = {}
  paths[start_position.join('_')] = [start_position]
  while true
    frontier.sort_by! { |pos| paths[pos.join('_')].length + manhattan(pos, maze_end) }
    current_position = frontier.shift
    break if current_position == maze_end
    legal_actions(current_position, open_list).each do |action|
      next if closed_set.include?(action)
      closed_set << action
      frontier << action
      paths[action.join('_')] = paths[current_position.join('_')] + [action]
    end
  end
  paths[maze_end.join('_')]
end

def open_spaces(maze)
  open_list = Set.new
  0.upto(maze.length - 1) do |x|
    0.upto(maze[0].length - 1) do |y|
      open_list << [x,y] if maze[x][y]
    end
  end
  open_list
end

def legal_actions(current_coord, open_list)
  new_pos = [
    [current_coord[0]+1, current_coord[1]], #Right
    [current_coord[0], current_coord[1]+1], #Down
    [current_coord[0]-1, current_coord[1]], #Left
    [current_coord[0], current_coord[1]-1]  #Up
  ]
  new_pos.select { |pos| open_list.include?(pos) } #Returns empty new positions surrounding the current position
end

p a_star_search(maze_start, maze, maze_end)

def add_path_to_maze(path, maze)
  path.each do |coord|
    maze[coord[0]][coord[-1]] = "X"
  end
  maze
end

path = a_star_search(maze_start, maze, maze_end)
maze_map = File.readlines("maze1.txt")
solution = add_path_to_maze(path, maze_map)
File.open("maze_solution.txt", 'w') { |file| file.write(solution.join) }