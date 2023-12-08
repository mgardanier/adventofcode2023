# frozen_string_literal: true

class PartTwo
  def self.run
    new.run
  end

  def run
    read_input
    find_start_nodes
    get_turns_for_starting_positions
    puts @turns_for_positions.values.reduce(1, :lcm)
    # puts follow_all_paths
  end

  def get_turns_for_starting_positions
    @turns_for_positions = {}
    @start_nodes.each do |key|
      @turns_for_positions[key] = total_turns_to_exit_from_starting_key(key)
    end
    # puts @turns_for_positions
  end

  def follow_all_paths
    total_turns = 0
    current_nodes = @start_nodes
    next_turn_index = 0
    finished = false
    until finished
      next_nodes = []
      for i in 0..current_nodes.length - 1
        next_nodes << @map[current_nodes[i]][@turns[next_turn_index]]
      end
      puts "Turns: #{total_turns}, Nodes: #{next_nodes.join(', ')}"
      current_nodes = next_nodes
      finished = current_nodes.all? { |node_string| node_string.end_with?('Z') }
      next_turn_index = (next_turn_index + 1) % @turns.length
      total_turns += 1
    end
    return total_turns
  end


  def find_start_nodes
    @start_nodes = []
    @map.each do |key, value|
      @start_nodes << key if key.end_with?('A')
    end
  end

  def total_turns_to_exit_from_starting_key(key)
    total_turns = 0
    position = key
    next_turn_index = 0
    until position.end_with?('Z')
      next_position = @map[position][@turns[next_turn_index]]
      position = next_position
      total_turns += 1
      next_turn_index = (next_turn_index + 1) % @turns.length
    end
    return total_turns
  end

  def read_input
    input = File.read('./day_8/input.txt').split("\n")
    @turns = input[0].split('')
    @map = {}
    for i in 2..input.length - 1
      map_key = input[i].split(' = ')[0]
      turn_options = input[i].split(' = ')[1].gsub(/[()]/, '').split(', ')
      @map[map_key] = {
        'L' => turn_options[0],
        'R' => turn_options[1]
      }
    end
  end
end

PartTwo.run
