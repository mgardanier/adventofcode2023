# frozen_string_literal: true

class PartOne
  def self.run
    new.run
  end

  def run
    parse_input
    get_expanded_rows
    get_expanded_columns
    # use manhattan distance formula
    print_map
  end

  def get_expanded_columns
    @expanded_columns ||= []
    for column in 0..@map[0].length - 1
      column_clear = true
      for row in @map
        if row[column] == '#'
          column_clear = false
          break
        end
      end
      if column_clear
        @expanded_columns << column
      end
    end
  end

  def get_expanded_rows
    @expanded_rows ||= []
    for row in 0..@map.length - 1
      unless @map[row].include?('#')
        @expanded_rows << row
      end
    end
  end
  def parse_input
    file = File.read('./day_11/input.txt').split("\n")
    @map = []
    for line in file
      @map << line.split('')
    end
  end

  def print_map
    for line in @map
      puts line.join
    end
  end
end

PartOne.run
