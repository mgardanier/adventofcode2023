# frozen_string_literal: true

class PartOne
  def self.run
    new.run
  end

  def run
    read_input
    puts get_game_power_sum
  end

  def read_input
    input = File.read('./day_2/input.txt').split("\n")
    parse_games(input)
    puts @games
  end

  def parse_games(input)
    @games = {}
    input.each do |line|
      key = line.split(':')[0].split(' ')[1]
      value = {}
      reveals = line.split(':')[1].split(';')
      blue = 0
      red = 0
      green = 0
      for reveal in reveals
        blue_reveal = get_value_for_color('blue', reveal)
        blue = blue_reveal if blue_reveal > blue
        red_reveal = get_value_for_color('red', reveal)
        red = red_reveal if red_reveal > red
        green_reveal = get_value_for_color('green', reveal)
        green = green_reveal if green_reveal > green
      end
      value['blue'] = blue
      value['red'] = red
      value['green'] = green
      value['power'] = blue * red * green
      @games[key] = value
    end
  end

  def get_value_for_color(color, reveal_string)
    arr = reveal_string.gsub(',', '').split(' ').compact
    color_index = arr.index(color)
    return 0 unless color_index
    return arr[color_index - 1].to_i
  end

  def get_game_power_sum
    green_limit = 13
    blue_limit = 14
    red_limit = 12
    sum = 0
    @games.each do |key, value|
      sum += value['power']
    end
    return sum
  end
end

PartOne.run
