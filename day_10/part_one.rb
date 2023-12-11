# frozen_string_literal: true

class PartOne
  def self.run
    new.run
  end

  def run
    parse_input
    # @steps = 0
    @visited = {}
    # @visited[@start_point] = 0
    # dfs_recursive(@start_point[0], @start_point[1], 0)
    dfs_straight_up
    # print_visited
    puts (get_biggest_adjacent_to_start) / 2
  end

  def dfs_straight_up
    stack = []
    stack.push(@start_point)
    # @visited[@start_point] = 0
    steps = 0
    until stack.empty?
      current = stack.pop
      @visited[current] = steps
      neighbors = next_position(current[0], current[1])
      steps += 1
      neighbors.each do |neighbor|
        if @visited[neighbor].nil?
          stack.push(neighbor)
        end
      end
    end
  end

  def dfs_recursive(x, y, steps)
    neighbors = next_position(x, y)
    neighbors.each do |neighbor|
      if @visited[neighbor].nil?
        @visited[neighbor] = steps + 1
        dfs_recursive(neighbor[0], neighbor[1], steps + 1)
      end
      # if @map[neighbor[1]][neighbor[0]] == 'S'
      #   @steps = steps + 1
      #   return
      # end
    end
  end

  def get_biggest_adjacent_to_start
    biggest_steps = 0
    above = [@start_point[0], @start_point[1] - 1]
    below = [@start_point[0], @start_point[1] + 1]
    left = [@start_point[0] - 1, @start_point[1]]
    right = [@start_point[0] + 1, @start_point[1]]
    neighbors = [above, below, left, right]
    neighbors.each do |neighbor|
      neighbors.delete(neighbor) if neighbor[0] < 0 || neighbor[1] < 0
    end
    neighbors.each do |neighbor|
      if @visited[neighbor] > biggest_steps
        biggest_steps = @visited[neighbor]
      end
    end
    return biggest_steps
  end

  def print_visited
    puts "****"
    for y in 0..@map.length - 1
      for x in 0..@map[y].length - 1
        print @visited[[x, y]] || "*"
      end
      print "\n"
    end
    puts "****"
  end

  def dfs
    @visited = {}
    @stack = []
    @stack.push(@start_point)
    @visited[@start_point] = 0
    first_time = true
    step_count = 1
    until @stack.empty?
      y_current, x_current = @stack.pop
      neighbors = next_position(x_current, y_current)
      neighbors.each do |neighbor|
        if @visited[neighbor] == 0 && first_time == false
          @visited[neighbor] = step_count
          return step_count
        end
        first_time = false
        next unless @visited[neighbor].nil?
        @visited[neighbor] = step_count
        @stack.push(neighbor)
      end
      step_count += 1
    end
  end

  # def bfs
  #   @queue = Queue.new
  #   @queue.push(@start_point)
  #   @visited = {}
  #   @visited[@start_point] = true
  #   @step_count = 1
  #   until @queue.empty?
  #     y_current, x_current = @queue.pop
  #     neighbors = next_position(x_current, y_current)
  #     neighbors.each do |next_position|
  #       puts "#{next_position[0]}, #{next_position[1]}"
  #       next unless @visited[next_position].nil?
  #       @visited[next_position] = @step_count
  #       @queue.push(next_position)
  #     end
  #     @step_count += 1
  #   end
  #   puts @step_count / 2
  # end

  def next_position(x_current, y_current)
    neighbors = []
    current = @map[y_current][x_current]
    if current == '|'
      above = [x_current, y_current - 1]
      below = [x_current, y_current + 1]
      neighbors = [above, below]
    elsif current == '-'
      left = [x_current - 1, y_current]
      right = [x_current + 1, y_current]
      neighbors = [left, right]
    elsif current == '7'
      left = [x_current - 1, y_current]
      below = [x_current, y_current + 1]
      neighbors = [left, below]
    elsif current == 'J'
      left = [x_current - 1, y_current]
      above = [x_current, y_current - 1]
      neighbors = [left, above]
    elsif current == 'L'
      right = [x_current + 1, y_current]
      above = [x_current, y_current - 1]
      neighbors = [right, above]
    elsif current == 'F'
      right = [x_current + 1, y_current]
      below = [x_current, y_current + 1]
      neighbors = [right, below]
    elsif current == 'S'
      left = [x_current - 1, y_current]
      right = [x_current + 1, y_current]
      above = [x_current, y_current - 1]
      below = [x_current, y_current + 1]
      neighbors = [left, right, above, below]
    end
    neighbors.each do |neighbor|
      neighbors.delete(neighbor) if neighbor[0] < 0 || neighbor[1] < 0
    end
    return neighbors
  end

  def parse_input
    file = File.read('./day_10/input.txt').split("\n")
    @map = []
    for line in file
      @map << line.split('')
      if line.split('').include?('S')
        @start_point = [line.split('').index('S'), file.index(line)]
      end
    end
  end
end

PartOne.run
