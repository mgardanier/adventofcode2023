
class PartTwo
  def self.run
    new.run
  end

  def initialize
    @times = []
    @distances = []
  end

  def read_input
    input = File.read('./day_6/input.txt').split("\n")
    @times = input[0].split(' ').map(&:to_i)
    @distances = input[1].split(' ').map(&:to_i)
    @times.shift
    @distances.shift
  end

  def run
    read_input

    total_combo_calc = 1
    for index in 0..@times.length - 1
      distance_total = get_number_of_winning_combos(@distances[index], @times[index])
      total_combo_calc *= distance_total
    end
    puts total_combo_calc
  end

  def get_number_of_winning_combos(record_distance, time)
    total_winning_combos = 0
    for hold_time in 0..time
      run_time = time - hold_time
      distance = hold_time * run_time
      if distance > record_distance
        total_winning_combos += 1
      end
    end
    return total_winning_combos
  end
end

PartTwo.run
