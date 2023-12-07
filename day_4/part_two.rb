# frozen_string_literal: true

class PartOne
  def self.run
    new.run
  end

  def run
    @cards = read_input
    sum = 0
    @copies = {}
    @cards.each do |key, value|
      sum += get_card_value(key, value)
    end
    calculate_from_copies
    puts sum
  end

  def read_input
    input = File.read('./day_4/input.txt').split("\n")
    cards = {}
    for line in input
      key = line.split(':')[0].split(' ')[1]
      numbers = line.split(':')[1]
      winners = numbers.split('|')[0].split(' ').map(&:to_i)
      my_numbers = numbers.split('|')[1].split(' ').map(&:to_i)

      cards[key] = {
        winners: winners,
        my_numbers: my_numbers
      }
    end
    return cards
  end

  def get_card_value(key, card)
    matches = card[:winners] & card[:my_numbers]
    return 0 if matches.length == 0
    score = 1
    calculate_copies(key, matches.length)
    return score if matches.length == 1
    for i in 0..matches.length - 2
      score *= 2
    end
    return score
  end

  def calculate_copies(key, num_matches)
    for i in 1..num_matches
      index = key.to_i + i
      @copies[index.to_s] = @copies[index.to_s].nil? ? 1 : @copies[index.to_s] + 1
    end
  end

  def calculate_from_copies
    @copies.each do |key, value|
      get_card_value(key, @cards[key])
    end
  end

end

PartOne.run