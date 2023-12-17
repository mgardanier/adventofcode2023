# frozen_string_literal: true

class PartTwo
  def self.run
    new.run
  end

  def run
    parse_input
    horizontal_score = []
    vertical_score = []
    puzzle_num = 1
    @puzzles.each do |puzzle|
      vertical_points = []
      puzzle.each do |row|
        vertical_points << find_vertical_reflection_points(row)
      end
      vertical_point = vertical_points.inject(:&).first
      horizontal_point = find_horizontal_reflection_point(puzzle)
      horizontal_point += 1 if horizontal_point
      vertical_point += 1 if vertical_point
      horizontal_score << horizontal_point
      if horizontal_point.nil? && vertical_point.nil?
        puts puzzle_num
      end
      vertical_score << vertical_point
      puzzle_num += 1
    end
    puts vertical_score.reject(&:nil?).sum + (100 * horizontal_score.reject(&:nil?).sum)
  end

  def find_horizontal_reflection_point(puzzle)
    i = 0
    reflection_point = 0
    loop do
      j = i + 1
      break if j >= puzzle.length
      a_row = puzzle[i]
      b_row = puzzle[j]
      if a_row == b_row
        found = true
        window_width = [i + 1, (puzzle.length - j)].min || 0
        sub_array_a = puzzle[(i + 1) - window_width..i]
        sub_array_b = puzzle[j..j + (window_width-1)]
        sub_array_a.reverse!
        found = sub_array_a == sub_array_b
        return i if found
      end
      i += 1
    end
    return nil
  end

  def find_vertical_reflection_points(row)
    reflection_points = []
    i = 0
    loop do
      j = i + 1
      break if j >= row.length
      if row[i] == row[j]
        # check for reflection
        a_string = row[..i]
        b_string = row[j..]
        string_length = [a_string.length, b_string.length].min
        a_string = a_string[-string_length..]
        a_string = a_string.reverse
        b_string = b_string[..string_length - 1]

        reflection_points << i if a_string == b_string
      end
      i += 1
    end
    return reflection_points
  end

  def parse_input
    file = File.read('./day_13/input.txt').split("\n\n")
    @puzzles = []
    file.each do |puzzle|
      @puzzles << puzzle.split("\n").map { |row| row.split('') }
    end
  end
end

PartTwo.run
