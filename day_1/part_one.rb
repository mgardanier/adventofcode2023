# frozen_string_literal: true

class PartOne
  def self.run
    new.run
  end

  def run
    file = File.read('./day_1/input.txt')

    sum = 0
    file.each_line do |line|
      line.tr!('^0-9', '')
      sum += (line[0] + line[-1]).to_i
    end
    puts sum
  end

end

PartOne.run
