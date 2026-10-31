# Solving letter-arithmetic puzzles with backtracking.
def solve(words, result)
  letters = (words.join + result).chars.uniq
  leading = (words + [result]).map { |w| w[0] }.uniq
  value = ->(w, a) { w.chars.reduce(0) { |acc, ch| acc * 10 + a[ch] } }
  solutions = []
  search = lambda do |i, assigned, used|
    if i == letters.size
      solutions << assigned.dup if words.sum { |w| value.(w, assigned) } == value.(result, assigned)
      return
    end
    (0..9).each do |d|
      next if used[d] || (d.zero? && leading.include?(letters[i]))
      assigned[letters[i]] = d
      used[d] = true
      search.(i + 1, assigned, used)
      used[d] = false
    end
    assigned.delete(letters[i])
  end
  search.(0, {}, Array.new(10, false))
  solutions
end

def show(words, result, s) = (words + [result]).map { |w| w.chars.map { |c| s[c] }.join }.then { |n| "#{n[0...-1].join(' + ')} = #{n[-1]}" }

[[%w[TO GO], "OUT"], [%w[ODD ODD], "EVEN"]].each do |words, result|
  sols = solve(words, result)
  puts "#{words.join(' + ')} = #{result}: #{sols.size} solution(s)"
  sols.first(3).each { |sol| puts "  #{show(words, result, sol)}" }
end
ab = solve(%w[AB BA], "CAC")
puts "AB + BA = CAC: #{ab.map { |s| s.sort.to_h }.inspect}"
