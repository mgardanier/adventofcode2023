# frozen_string_literal: true

class PartOne
  def self.run
    new.run
  end

  def run
    @cards = read_input
    @cards.each do |key, value|
      for i in 1..value[:copies]
        get_card_value(key, value)
      end
    end
    sum = 0
    @cards.each do |key, value|
      sum += value[:copies]
    end
    puts sum
  end

  def get_card_value(key, card)
    matches = card[:winners] & card[:my_numbers]
    return 0 if matches.length == 0
    calculate_copies(key, matches.length)
  end

  def calculate_copies(key, num_matches)
    for i in 1..num_matches
      index = (key.to_i + i).to_s
      @cards[index][:copies] += 1
    end
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
        my_numbers: my_numbers,
        copies: 1
      }
    end
    return cards
  end
end

PartOne.run