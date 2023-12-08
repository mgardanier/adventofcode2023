# frozen_string_literal: true

class PartTwo

  def self.run
    new.run
  end

  def parse_map(section)
    destination_ranges = []
    source_ranges = []
    mappings = section.split("\n").drop(1)
    mappings.each do |mapping|
      destination_start, source_start, range = mapping.split(" ").map(&:to_i)
      range = range - 1
      destination_ranges << [destination_start, destination_start + range]
      source_ranges << [source_start, source_start + range]
    end
    return { destination_ranges: destination_ranges, source_ranges: source_ranges }
  end

  def parse_seeds(section)
    seeds = []
    seed_ranges = section.split(' ').drop(1).map(&:to_i)
    seed_ranges.each_with_index do |seed_range, i|
      next unless i % 2 == 0
      range = seed_ranges[i + 1]
      seeds << [seed_range, range]
    end
    return seeds
  end

  def parse_file(file)
    seed_info = {
      seed_tuples: [],
      seed_to_soil: { destination_ranges: [], source_ranges: [] },
      soil_to_fertilizer: { destination_ranges: [], source_ranges: [] },
      fertilizer_to_water: { destination_ranges: [], source_ranges: [] },
      water_to_light: { destination_ranges: [], source_ranges: [] },
      light_to_temperature: { destination_ranges: [], source_ranges: [] },
      temperature_to_humidity: { destination_ranges: [], source_ranges: [] },
      humidity_to_location: { destination_ranges: [], source_ranges: [] }
    }
    file = file.split("\n\n")
    seed_info[:seed_tuples] = parse_seeds(file.shift)
    seed_info[:seed_to_soil] = parse_map(file.shift)
    seed_info[:soil_to_fertilizer] = parse_map(file.shift)
    seed_info[:fertilizer_to_water] = parse_map(file.shift)
    seed_info[:water_to_light] = parse_map(file.shift)
    seed_info[:light_to_temperature] = parse_map(file.shift)
    seed_info[:temperature_to_humidity] = parse_map(file.shift)
    seed_info[:humidity_to_location] = parse_map(file.shift)
    return seed_info
  end

  def follow_map(map, seed)
    destination_index = nil
    map[:source_ranges].each_with_index do |source_range, i|
      if seed >= source_range[0] && seed <= source_range[1]
        destination_index = i
        break
      end
    end
    return seed if destination_index.nil?
    map[:destination_ranges][destination_index].first + (seed - map[:source_ranges][destination_index].first)
  end

  def run
    file = File.read('./day_5/input.txt')

    seed_info = parse_file(file)

    key_maps = seed_info.keys.drop(1)
    final_value = 2147483647
    seed_info[:seed_tuples].each do |seed_tuple|
      seed_start = seed_tuple[0]
      range = seed_tuple[1]
      index = 0
      puts "tuple #{index}"
      loop do
        break if index >= range
        new_value = seed_start + index
        key_maps.each do |key_map|
          new_value = follow_map(seed_info[key_map], new_value)
        end
        final_value = new_value if new_value < final_value
        index += 1
      end
    end
    puts final_value
  end
end

PartTwo.run
