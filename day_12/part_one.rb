# frozen_string_literal: true

class PartOne
  def self.run
    new.run
  end

  def run
    parse_input
    find_total_arrangements
  end


  def find_total_arrangements
    counter = 0
    @input_data.each do |input|
      counter += dp_brute(input[:springs], input[:positions], 0, 0, 0)
    end
    puts counter
  end
  def dp_brute(dots, blocks, dots_index, blocks_index, current_block)
    if dots_index == dots.length
      if blocks_index == blocks.length && current_block == 0
        return 1
      elsif blocks_index == blocks.length - 1 && blocks[blocks_index] == current_block
        return 1
      else
        return 0
      end
    end

    result = 0
    [".", "#"].each do |c|
      if dots[dots_index] == c || dots[dots_index] == '?'
        if c == '.' and current_block == 0
          result += dp_brute(dots, blocks, dots_index + 1, blocks_index, 0)
        elsif c == '.' && current_block > 0 && blocks_index < blocks.length && blocks[blocks_index] == current_block
          result += dp_brute(dots, blocks, dots_index + 1, blocks_index + 1, 0)
        elsif c == '#'
          result += dp_brute(dots, blocks, dots_index + 1, blocks_index, current_block + 1)
        end
      end
    end
    return result
  end
  def parse_input
    file = File.read('./day_12/input.txt').split("\n")
    @input_data = []
    for line in file
      line_parts = line.split(' ')
      springs = line_parts[0].split('')
      positions = line_parts[1].split(',').map(&:to_i)
      @input_data << {
        springs: springs,
        positions: positions
      }
    end
  end
end

PartOne.run
