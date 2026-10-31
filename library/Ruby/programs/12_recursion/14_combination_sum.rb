# Backtracking: combinations that add up to a target.
def combination_sum(candidates, target, start = 0, path = [], out = [])
  if target.zero?
    out << path.dup
    return out
  end
  (start...candidates.size).each do |i|
    c = candidates[i]
    break if c > target
    path << c
    combination_sum(candidates, target - c, i, path, out)
    path.pop
  end
  out
end

def unique_combination_sum(cands, target, start = 0, path = [], out = [])
  return out << path.dup if target.zero?
  (start...cands.size).each do |i|
    next if i > start && cands[i] == cands[i - 1]
    break if cands[i] > target
    path << cands[i]
    unique_combination_sum(cands, target - cands[i], i + 1, path, out)
    path.pop
  end
  out
end

puts combination_sum([2, 3, 6, 7], 7).inspect
puts combination_sum([2, 3, 5], 8).inspect
puts unique_combination_sum([10, 1, 2, 7, 6, 1, 5].sort, 8).inspect
