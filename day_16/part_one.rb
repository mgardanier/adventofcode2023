# frozen_string_literal: true

class PartOne
  def self.run
    new.run
  end

  def run
    parse_input
    trace_beam
    puts @energized_positions.length
  end

  def trace_beam
    @energized_positions = {}
    follow_beam(0, 0, :right)
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
      follow_beam(next_position[:position][0], next_position[:position][1], next_position[:direction])
    end
  end

  def get_next_positions(x, y, direction)
    current = @map[y][x]
    next_positions = []
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

PartOne.run
