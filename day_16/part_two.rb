# frozen_string_literal: true

class PartTwo
  def self.run
    new.run
  end

  def run
    parse_input
    total_energized_for_start_positions = []


    # loop through top row
    for x_pos in 0..@map[0].length - 1
      trace_beam(x_pos, 0, :down)
      total_energized_for_start_positions << @energized_positions.length
    end

    # loop through bottom row
    for x_pos in 0..@map[@map.length - 1].length - 1
      trace_beam(x_pos, @map.length - 1, :up)
      total_energized_for_start_positions << @energized_positions.length
    end
    # loop through left most column
    for y_pos in 0..@map.length - 1
      trace_beam(0, y_pos, :right)
      total_energized_for_start_positions << @energized_positions.length
    end
    # loop through right most column
    for y_pos in 0..@map.length - 1
      trace_beam(@map[0].length - 1, y_pos, :left)
      total_energized_for_start_positions << @energized_positions.length
    end

    puts total_energized_for_start_positions.sort.last
  end

  def trace_beam(x, y, direction)
    @energized_positions = {}
    @stack = []

    start_pos = get_position_direction_hash(x, y, direction)
    @stack.push(start_pos)
    while @stack.length > 0 do
      next_pos = @stack.pop
      follow_beam(next_pos[:position][0], next_pos[:position][1], next_pos[:direction])
    end
    return @energized_positions
  end

  def follow_beam(x, y, direction)
    return if x < 0 || y < 0 || y >= @map.length || x >= @map[y].length

    if @energized_positions[[x, y]]
      #if been here moving this direction before, return
      if @energized_positions[[x, y]][:directions].include?(direction)
        return
      end
    end

    @energized_positions[[x, y]] ||= {
      directions: []
    }
    @energized_positions[[x, y]][:directions] << direction

    next_positions = get_next_positions(x, y, direction)
    next_positions.each do |next_position|
      # follow_beam(next_position[:position][0], next_position[:position][1], next_position[:direction])
      @stack.push(next_position)
    end
  end

  def get_next_positions(x, y, direction)
    current = @map[y][x]
    next_positions = []
    # return [] if @splits[[x, y, direction]] == true
    # @splits[[x, y, direction]] = true
    if current == '.'
      next_positions << get_position_direction_hash(x - 1, y, :left) if direction == :left
      next_positions << get_position_direction_hash(x + 1, y, :right) if direction == :right
      next_positions << get_position_direction_hash(x, y - 1, :up) if direction == :up
      next_positions << get_position_direction_hash(x, y + 1, :down) if direction == :down

    elsif current == '|'
      next_positions << get_position_direction_hash(x, y - 1, :up) if [:left, :right].include?(direction)
      next_positions << get_position_direction_hash(x, y + 1, :down) if [:left, :right].include?(direction)
      next_positions << get_position_direction_hash(x, y - 1, :up) if direction == :up
      next_positions << get_position_direction_hash(x, y + 1, :down) if direction == :down

    elsif current == '-'
      next_positions << get_position_direction_hash(x - 1, y, :left) if direction == :left
      next_positions << get_position_direction_hash(x + 1, y, :right) if direction == :right
      next_positions << get_position_direction_hash(x - 1, y, :left) if [:up, :down].include?(direction)
      next_positions << get_position_direction_hash(x + 1, y, :right) if [:up, :down].include?(direction)

    elsif current == '/'
      next_positions << get_position_direction_hash(x, y + 1, :down) if direction == :left
      next_positions << get_position_direction_hash(x, y - 1, :up) if direction == :right
      next_positions << get_position_direction_hash(x - 1, y, :left) if direction == :down
      next_positions << get_position_direction_hash(x + 1, y, :right) if direction == :up

    elsif current == '\\'
      next_positions << get_position_direction_hash(x, y - 1, :up) if direction == :left
      next_positions << get_position_direction_hash(x, y + 1, :down) if direction == :right
      next_positions << get_position_direction_hash(x + 1, y, :right) if direction == :down
      next_positions << get_position_direction_hash(x - 1, y, :left) if direction == :up
    end

    return next_positions
    # return check_next_positions_against_cache(next_positions)
  end

  def check_next_positions_against_cache(next_positions)
    new_positions = []
    next_positions.each do |next_position|
      unless @energized_positions[next_position[:position]] && @energized_positions[next_position[:position]][:directions].include?(next_position[:direction])
        new_positions << next_position
        @energized_positions[next_position[:position]] ||= {
          directions: []
        }
        @energized_positions[next_position[:position]][:directions] << next_position[:direction]
      end
    end
    return new_positions
  end

  def get_position_direction_hash(x, y, direction)
    return {
      position: [x, y],
      direction: direction
    }
  end

  def parse_input
    file = File.read('./day_16/input.txt').split("\n")
    @map = []
    for line in file
      @map << line
    end
  end
end

PartTwo.run
