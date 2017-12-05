require "csv"

PUZZLE_INPUT = File.read(ARGV[0])

def sum_each_row(input)
  CSV.each_row(input, separator: '\t').sum do |cells|
    yield cells.map(&.to_i)
  end
end

def part_one(input)
  sum_each_row(input) do |cells|
    min, max = cells.minmax
    max - min
  end
end

def part_two(input)
  sum_each_row(input) do |cells|
    combinations = cells.each_combination(2, reuse: true).map(&.sort)
    divisor, divident = combinations.find({ 0, 0 }) do |(a, b)|
      b % a == 0
    end

    divident / divisor
  end
end

puts part_one(PUZZLE_INPUT), part_two(PUZZLE_INPUT)