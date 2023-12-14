# frozen_string_literal: true

class PartOne
  def self.run
    new.run
  end

  def run
    parse_input
    slide_rocks
    weigh_platform
  end

  def weigh_platform
    total = 0
    for i in 0..@platform.length - 1
      row_factor = @platform.length - i
      total += row_factor * @platform[i].count('O')
    end
    puts "Total weight is #{total}"
  end

  def slide_rocks
    @changed = false
    for row_index in 1..@platform.length - 1
    # for row_index in 1..3
      slide_row_up(row_index)
    end
    if @changed
      slide_rocks
    end
  end

  def slide_row_up(row_index)
    row = @platform[row_index]
    row_above = @platform[row_index - 1]
    index = 0
    loop do
      break if index >= row.length
      char = row[index]
      if char == 'O'
        if row_above[index] == '.'
          row[index] = '.'
          row_above[index] = 'O'
          @changed = true
        end
      end

      index += 1
    end
  end
  def parse_input
    file = File.read('./day_14/input.txt').split("\n")
    @platform = []
    for line in file
      @platform << line
    end
  end
end

PartOne.run
