# frozen_string_literal: true

class PartOne
  def self.run
    new.run
  end

  def run
    parse_input
    get_expanded_rows
    get_expanded_columns
    distance = calculate_distance
    # print_map
    puts distance
  end

  def calculate_distance
    galaxies = find_galaxies_positions
    distances = {}
    for i in 1..galaxies.length
      for j in i + 1..galaxies.length
        distances[[i,j]] = manhatten_distance(galaxies[i][1], galaxies[i][0], galaxies[j][1], galaxies[j][0])
      end
    end
    return distances.values.sum
  end

  def manhatten_distance(x1, y1, x2, y2)
    return (x1 - x2).abs + (y1 - y2).abs
  end

  def find_galaxies_positions
    positions = {}
    num = 1
    for row in 0..@map.length - 1
      row_offset = @expanded_rows.count { |element | element < row  }
      for column in 0..@map[0].length - 1
        column_offset = @expanded_columns.count { |element| element < column }
        if @map[row][column] == '#'
          positions[num] = [row + row_offset, column + column_offset]
          num += 1
        end
      end
    end
    return positions
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
