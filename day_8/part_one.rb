# frozen_string_literal: true

class PartOne
  def self.run
    new.run
  end

  def run
    read_input
    puts total_turns_to_exit
  end

  def total_turns_to_exit
    total_turns = 0
    position = 'AAA'
    next_turn_index = 0
    while position != 'ZZZ'
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

PartOne.run
