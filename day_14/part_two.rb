# frozen_string_literal: true

class PartTwo
  def self.run
    new.run
  end

  def run
    parse_input
    slide_rocks
    weigh_platform
  end

  def slide_rocks
    # @cache = {}
    # for i in 0..1000000000
    for i in 0..2
      @changed = false
      slide_rocks_north
      slide_rocks_west
      slide_rocks_south
      slide_rocks_east
    puts i
      print_platform
    end
  end

  def print_platform
    for i in 0..@platform.length - 1
      puts @platform[i]
    end
    puts "\n"
  end

  def weigh_platform
    total = 0
    for i in 0..@platform.length - 1
      row_factor = @platform.length - i
      total += row_factor * @platform[i].count('O')
    end
    puts "Total weight is #{total}"
  end

  def slide_rocks_west
    @changed = false
    # key = [@platform, 'w']
    # if @cache[key]
    #   @platform = @cache[key] if @cache[key]
    #   return
    # end
    for row_index in 0..@platform.length - 1
      slide_row_left(row_index)
    end
    if @changed
      slide_rocks_west
    end
    # @cache[key] = @platform
  end

  def slide_rocks_east
    @changed = false
    # key = [@platform, 'e']
    # if @cache[key]
    #   @platform = @cache[key] if @cache[key]
    #   return
    # end
    for row_index in 0..@platform.length - 1
      slide_row_right(row_index)
    end
    if @changed
      slide_rocks_east
    end
    # @cache[key] = @platform
  end

  def slide_rocks_south
    @changed = false
    # key = [@platform, 's']
    # if @cache[key]
    #   @platform = @cache[key] if @cache[key]
    #   return
    # end
    for row_index in 0..@platform.length - 2
      slide_row_down(row_index)
    end
    if @changed
      slide_rocks_south
    end
    # @cache[key] = @platform
  end

  def slide_rocks_north
    @changed = false
    # key = [@platform, 'n']
    # if @cache[key]
    #   @platform = @cache[key] if @cache[key]
    #   return
    # end
    for row_index in 1..@platform.length - 1
      slide_row_up(row_index)
    end
    if @changed
      slide_rocks_north
    end
    # @cache[key] = @platform
  end

  def slide_row_left(row_index)
    row = @platform[row_index]
    for i in 1..row.length - 1
      if row[i] == 'O'
        if row[i - 1] == '.'
          row[i] = '.'
          row[i - 1] = 'O'
          @changed = true
        end
      end
    end
  end


  def slide_row_right(row_index)
    row = @platform[row_index]
    for i in 0..row.length - 2
      if row[i] == 'O'
        if row[i + 1] == '.'
          row[i] = '.'
          row[i + 1] = 'O'
          @changed = true
        end
      end
    end
  end

  def slide_row_down(row_index)
    row = @platform[row_index]
    row_below = @platform[row_index + 1]
    index = 0
    loop do
      break if index >= row.length
      char = row[index]
      if char == 'O'
        if row_below[index] == '.'
          row[index] = '.'
          row_below[index] = 'O'
          @changed = true
        end
      end
      index += 1
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

PartTwo.run
