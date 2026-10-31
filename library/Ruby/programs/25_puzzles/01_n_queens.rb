# The N-queens puzzle by backtracking.
def solve_queens(n)
  solutions = []
  cols = []
  place = lambda do |row|
    if row == n
      solutions << cols.dup
      return
    end
    n.times do |c|
      next if cols.each_with_index.any? { |cc, r| cc == c || (cc - c).abs == row - r }
      cols << c
      place.(row + 1)
      cols.pop
    end
  end
  place.(0)
  solutions
end

(4..8).each { |n| puts "#{n} queens: #{solve_queens(n).size} solutions" }
first = solve_queens(8).first
first.each { |c| puts (0...8).map { |i| i == c ? "Q" : "." }.join(" ") }
