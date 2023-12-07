# frozen_string_literal: true

class PartOne
  def self.run
    new.run
  end

  CARD_RANK = {
    '2' => 13,
    '3' => 12,
    '4' => 11,
    '5' => 10,
    '6' => 9,
    '7' => 8,
    '8' => 7,
    '9' => 6,
    'T' => 5,
    'J' => 4,
    'Q' => 3,
    'K' => 2,
    'A' => 1
  }

  HAND_RANK = {
    'five_of_a_kind' => 1,
    'four_of_a_kind' => 2,
    'full_house' => 3,
    'three_of_a_kind' => 4,
    'two_pair' => 5,
    'one_pair' => 6,
    'high_card' => 7
  }

  def run
    read_input
    classify_hands
    order_hands
    puts @hands
    puts calculate_winnings
  end

  def read_input
    input = File.read('./day_7/input.txt').split("\n")
    @hands = []
    for line in input
      hand = line.split(' ')[0]
      bid = line.split(' ')[1].to_i
      @hands << {
        hand: hand,
        bid: bid
      }
    end
  end

  def classify_hands
    @hands.each do |hand|
      hand[:hand_type] = get_hand_type(hand[:hand])
    end
  end

  def order_hands
    @hands = @hands.sort_by { |hand| [HAND_RANK[hand[:hand_type]], CARD_RANK[hand[:hand][0]], CARD_RANK[hand[:hand][1]], CARD_RANK[hand[:hand][2]], CARD_RANK[hand[:hand][3]], CARD_RANK[hand[:hand][4]]] }
    @hands.reverse!
  end

  def calculate_winnings
    winnings = 0
    for i in 1..@hands.length
      winnings += @hands[i - 1][:bid] * i
    end
    return winnings
  end

  def get_hand_type(hand)
    if is_five_of_a_kind(hand)
      return 'five_of_a_kind'
    elsif is_four_of_a_kind(hand)
      return 'four_of_a_kind'
    elsif is_full_house(hand)
      return 'full_house'
    elsif is_three_of_a_kind(hand)
      return 'three_of_a_kind'
    elsif is_two_pair(hand)
      return 'two_pair'
    elsif is_one_pair(hand)
      return 'one_pair'
    else
      return 'high_card'
    end
  end

  def is_five_of_a_kind(hand)
    counts = hand.chars.group_by(&:itself).transform_values(&:count)
    return counts.values.any? { |count| count == 5 }
  end

  def is_four_of_a_kind(hand)
    counts = hand.chars.group_by(&:itself).transform_values(&:count)
    return counts.values.any? { |count| count == 4 }
  end

  def is_full_house(hand)
    counts = hand.chars.group_by(&:itself).transform_values(&:count)
    return counts.values.any? { |count| count == 3 } && counts.values.any? { |count| count == 2 }
  end

  def is_three_of_a_kind(hand)
    counts = hand.chars.group_by(&:itself).transform_values(&:count)
    return counts.values.any? { |count| count == 3 }
  end

  def is_two_pair(hand)
    counts = hand.chars.group_by(&:itself).transform_values(&:count)
    if counts.values.count { |count| count == 2 } == 2
      return true
    end
  end

  def is_one_pair(hand)
    counts = hand.chars.group_by(&:itself).transform_values(&:count)
    if counts.values.count { |count| count == 2 } == 1
      return true
    end
  end

end

PartOne.run
