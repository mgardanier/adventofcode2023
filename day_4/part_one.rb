# frozen_string_literal: true

class PartTwo
  def self.run
    new.run
  end

  def run
    @cards = read_input
    sum = 0
    @cards.each do |key, value|
      sum += get_card_value(value)
    end
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

  def get_card_value(card)
    matches = card[:winners] & card[:my_numbers]
    return 0 if matches.length == 0
    score = 1
    return score if matches.length == 1
    for i in 0..matches.length - 2
      score *= 2
    end
    return score
  end
end

PartTwo.run