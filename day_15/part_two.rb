# frozen_string_literal: true

class PartTwo
  def self.run
    new.run
  end
  def run
    parse_input
    initialize_hash
    puts calculate_total_power
  end

  def calculate_total_power
    total_power = 0
    for i in 0..255
      box_number = i + 1
      box = @hash[i]
      box_lens_powers = []
      lens_index = 0
      box.each do |lens, focal_length|
        total_power += box_number * (lens_index + 1) * focal_length.to_i
        lens_index += 1
      end
    end
    return total_power
  end

  def initialize_hash
    @hash = {}
    (0..255).each { |i| @hash[i] = {} }
    for i in 0..@input_data.length - 1
      lens, operator, focal_length = get_step_parts(@input_data[i])
      box = get_hash_value(lens)
      # if there is a problem, i bet it's with the hash sorting when deleting/inserting
      if operator == '-'
        @hash[box].delete(lens)
      elsif operator == '='
        @hash[box][lens] = focal_length
      end
    end
  end

  def get_step_parts(step)
    operator = ""
    operator = '-' if step.include?('-')
    operator = '=' if step.include?('=')
    parts = step.split(/[=-]/)
    lens = parts[0]
    focal_length = nil
    focal_length = parts[1] if parts.length > 1
    return lens, operator, focal_length
  end
  def get_hash_value(input)
    current_value = 0
    for i in 0..input.length - 1
      c = input[i]
      current_value += c.ord
      current_value *=  17
      current_value %= 256
    end
    # puts current_value
    return current_value
  end

  def parse_input
    @input_data = File.read('./day_15/input.txt').split(",")
  end
end

PartTwo.run
