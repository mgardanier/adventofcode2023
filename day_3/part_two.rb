# frozen_string_literal: true

class PartTwo
  def self.run
    new.run
  end

  def run
    read_input
    @gear_positions = []
    check_matrix
    remove_adjacent_valid_positions
    # find_numbers_from_valid_positions.sum
    @gear_positions.uniq!
    gear_ratios = find_adjacent_numbers
    puts gear_ratios.sum
  end

  def find_adjacent_numbers
    number_positions = {}
    for position in @gear_positions
      number_positions[position] = get_adjacent_spots_for_number(position[0], position[1])
    end
    number_positions.each do |key, value|
      if value.length == 1
        number_positions.delete(key)
      end
    end
    numbers = []
    number_positions.each do |key, value|
      @valid_positions = value.sort
      remove_adjacent_valid_positions
      next if @valid_positions.length != 2
      number = find_numbers_from_valid_positions.reduce(:*)
      numbers << number
    end
    return numbers
  end


  def read_input
    input = File.read('./day_3/input.txt').split("\n")
    @matrix = []
    for line in input
      @matrix << line.split('')
    end
  end

  def check_matrix
    @valid_positions = []
    for i in 0..@matrix.length - 1
      for j in 0..@matrix[i].length - 1
        # check_adjacent_spots_for_symbol(i, j)
        next if @matrix[i][j] == '.'
        hit = check_adjacent_spots_for_symbol(i, j)
        if hit
          @valid_positions << [i, j]
        end
      end
    end
    # @valid_positions.each do |position|
    #   puts "(#{position[0]}, #{position[1]})"
    # end
  end
  
  def remove_adjacent_valid_positions
    bad_positions = []
    for i in 0..@valid_positions.length - 1
      break if i >= @valid_positions.length - 1
      if @valid_positions[i][0] != @valid_positions[i + 1][0]
        next
      end
      if @valid_positions[i][1] == @valid_positions[i + 1][1] - 1
        # @valid_positions.delete_at(i + 1)
        bad_positions << @valid_positions[i + 1]
      end
    end
    @valid_positions = @valid_positions - bad_positions
  end

  def find_numbers_from_valid_positions
    numbers = []
    for position in @valid_positions
      numbers << get_number_touching_position(position[0], position[1])
    end
    return numbers
  end

  def get_number_touching_position(x, y)
    # get every number left of position
    numbers_left = []
    for i in 1..y
      break unless is_number(x, y - i)
      numbers_left << @matrix[x][y - i]
    end

    # get every digit right of position
    numbers_right = []
    for i in 1..(@matrix[x].length - y - 1)
      break unless is_number(x, y + i)
      numbers_right << @matrix[x][y + i]
    end

    number = "#{numbers_left.reverse.join}#{@matrix[x][y]}#{numbers_right.join}".to_i
    return number
  end

  def check_adjacent_spots_for_symbol(x, y)
    # check x + 1
    unless x == @matrix.length - 1
      return true if is_symbol(x + 1, y)
    end
    # check x - 1
    unless x == 0
      return true if is_symbol(x - 1, y)
    end
    # check y + 1
    unless y == @matrix[x].length - 1
      return true if is_symbol(x, y + 1)
    end
    # check y - 1
    unless y == 0
      return true if is_symbol(x, y - 1)
    end
    # check x + 1, y + 1
    unless x == @matrix.length - 1 || y == @matrix[x].length - 1
      return true if is_symbol(x + 1, y + 1)
    end
    # check x + 1, y - 1
    unless x == @matrix.length - 1 || y == 0
      return true if is_symbol(x + 1, y - 1)
    end
    # check x - 1, y + 1
    unless x == 0 || y == @matrix[x].length - 1
      return true if is_symbol(x - 1, y + 1)
    end
    # check x - 1, y - 1
    unless x == 0 || y == 0
      return true if is_symbol(x - 1, y - 1)
    end
  end

  def get_adjacent_spots_for_number(x, y)
    match_coordinates = []
    # check x + 1
    unless x == @matrix.length - 1
      if is_number(x + 1, y)
        match_coordinates << [x + 1, y]
      end
    end
    # check x - 1
    unless x == 0
      if is_number(x - 1, y)
        match_coordinates << [x - 1, y]
      end
    end
    # check y + 1
    unless y == @matrix[x].length - 1
      if is_number(x, y + 1)
        match_coordinates << [x, y + 1]
      end
    end
    # check y - 1
    unless y == 0
      if is_number(x, y - 1)
        match_coordinates << [x, y - 1]
      end
    end
    # check x + 1, y + 1
    unless x == @matrix.length - 1 || y == @matrix[x].length - 1
      if is_number(x + 1, y + 1)
        match_coordinates << [x + 1, y + 1]
      end
    end
    # check x + 1, y - 1
    unless x == @matrix.length - 1 || y == 0
      if is_number(x + 1, y - 1)
        match_coordinates << [x + 1, y - 1]
      end
    end
    # check x - 1, y + 1
    unless x == 0 || y == @matrix[x].length - 1
      if is_number(x - 1, y + 1)
        match_coordinates << [x - 1, y + 1]
      end
    end
    # check x - 1, y - 1
    unless x == 0 || y == 0
      if is_number(x - 1, y - 1)
        match_coordinates << [x - 1, y - 1]
      end
    end
    return match_coordinates
  end

  def is_symbol(x, y)
    char = @matrix[x][y]
    return false if char == '.'
    if char.match?(/\W/)
      @gear_positions << [x, y] if char == '*'
      return true
    end
  end

  def is_number(x, y)
    char = @matrix[x][y]
    return char.match?(/\d/)
  end
end

PartTwo.run