# Finding words in a letter grid in all eight directions.
GRID = %w[
  RUBYXQ
  AOLMNE
  ILAGOP
  LSTACK
  SDNOMO
  HASHED
].map(&:chars)

DIRS = [[0, 1], [1, 0], [1, 1], [-1, 1], [0, -1], [-1, 0], [-1, -1], [1, -1]].freeze

def find_word(word)
  GRID.each_index do |r|
    GRID[r].each_index do |c|
      DIRS.each do |dr, dc|
        cells = word.length.times.map { |k| [r + dr * k, c + dc * k] }
        next unless cells.all? { |y, x| y.between?(0, GRID.size - 1) && x.between?(0, GRID[0].size - 1) }
        return [r, c, dr, dc] if cells.map { |y, x| GRID[y][x] }.join == word
      end
    end
  end
  nil
end

%w[RUBY RAILS STACK HASHED ALTO ADS DEHS GOAL JAVA].each do |w|
  hit = find_word(w)
  puts hit ? "#{w.ljust(6)} at row #{hit[0]}, col #{hit[1]} going #{[hit[2], hit[3]].inspect}" : "#{w.ljust(6)} not found"
end
