# frozen_string_literal: true

class PartOne
  def self.run
    new.run
  end
  def run
    parse_input
    puts get_total_score
    puts "hi"
  end

  def get_total_score
    score = 0
    for input in @input_data
      score += get_hash_value(input)
    end
    return score
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

PartOne.run
