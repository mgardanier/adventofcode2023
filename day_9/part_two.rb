# frozen_string_literal: true

class PartTwo
  def self.run
    new.run
  end
  def run
    parse_input
    # reverse_input
    predict_next_values
  end

  def reverse_input
    @input_data = @input_data.map{|x| x.split(' ').map(&:to_i)}.map{|x| x.reverse}
  end

  def predict_next_values
    extra_values = []
    @input_data.each do |input_array|
      differences = find_differences(input_array)
      input_array.unshift(input_array.first - differences.first)
      extra_values << input_array.first
      puts input_array.join(' ')
    end
    puts extra_values.sum
  end

  def find_differences(input_array)
    differences_array = []
    index = input_array.length - 1
    input_array.reverse_each do |value|
      break if index == 0
      differences_array.unshift(value - input_array[index - 1])
      index -= 1
    end
    if differences_array.uniq.length == 1 && differences_array[0] == 0
      return differences_array
    end
    first_value = differences_array.first - find_differences(differences_array).first
    differences_array.unshift(first_value)
    return differences_array
  end

  def parse_input
    file = File.read('./day_9/input.txt').split("\n")
    @input_data = file
    @input_data = @input_data.map{|x| x.split(' ').map(&:to_i)}
  end
end

PartTwo.run
