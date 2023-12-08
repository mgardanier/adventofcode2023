# frozen_string_literal: true

class PartTwo
  def self.run
    new.run
  end
  def run
    file = File.read('./day_1/input.txt')
    sum = 0
    file.each_line do |line|
      first = find_number(line)
      last = find_number(line.reverse, true)
      result = first + last
      sum += result.to_i
    end
    puts sum
  end

  def find_number(line, reversed=false)
    conversion = {
      'one'=> '1',
      'two'=> '2',
      'three'=> '3',
      'four'=> '4',
      'five'=> '5',
      'six'=> '6',
      'seven'=> '7',
      'eight'=> '8',
      'nine'=> '9'
    }

    number = ''
    (0..line.length).each do |index|
      substr = line[0..index]
      substr_numbers = substr.tr('^0-9', '')
      matched = substr_numbers == "" ? false : substr_numbers
      if matched
        number = matched
        break
      end

      conversion.keys.each do |key|
        key = key.reverse if reversed
        matched = substr.include?(key)
        number = conversion[key] || conversion[key.reverse]
        break if matched
      end
      break if matched
    end
    return number
  end
end

PartTwo.run
