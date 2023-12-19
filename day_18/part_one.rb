# frozen_string_literal: true

class PartOne
  def self.run
    new.run
  end

  def run
    parse_input
    @site = []
    dig_exterior

  end

  def dig_exterior

  end

  def parse_input
    file = File.read('./day_18/input.txt').split("\n")
    @dig_plan = []
    for line in file
      instructions = line.split(' ')
      direction = instructions[0]
      distance = instructions[1].to_i
      color = instructions[2].gsub(/[()]/, '')
      @dig_plan << {
        direction: direction,
        distance: distance,
        color: color
      }
    end
  end
end

PartOne.run
