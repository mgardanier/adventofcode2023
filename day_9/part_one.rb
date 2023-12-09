# frozen_string_literal: true

class PartOne
  def self.run
    new.run
  end
  def run
    parse_input
    predict_next_values
  end

  def predict_next_values
    extra_values = []
    @input_data.each do |input|
      input_array = input.split(' ').map(&:to_i)
      differences = find_differences(input_array)
      input_array << differences.last + input_array.last
      extra_values << input_array.last
      puts input_array.join(' ')
    end
    puts extra_values.sum
  end

  def find_differences(input_array)
    differences_array = []
    for i in 0..input_array.length - 2
      differences_array << input_array[i + 1] - input_array[i]
    end
    if differences_array.uniq.length == 1 && differences_array[0] == 0
      return differences_array
    end
    last_value = find_differences(differences_array).last + differences_array.last
    differences_array << last_value
    return differences_array
  end

  def parse_input
    file = File.read('./day_9/input.txt').split("\n")
    @input_data = file
  end
end

PartOne.run
