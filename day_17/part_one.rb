# frozen_string_literal: true

class PartOne
  def self.run
    new.run
  end

  def run
    parse_input
  end

  def parse_input
    file = File.read('./day_17/input.txt').split("\n")
  end
end

PartOne.run
