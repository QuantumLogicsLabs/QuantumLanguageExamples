# Measuring water with two jugs, solved by breadth-first search.
def jugs(cap_a, cap_b, goal)
  start = [0, 0]
  prev = { start => nil }
  queue = [start]
  until queue.empty?
    a, b = state = queue.shift
    return path(prev, state) if a == goal || b == goal
    pour_ab = [a, cap_b - b].min
    pour_ba = [b, cap_a - a].min
    nexts = {
      "fill A" => [cap_a, b], "fill B" => [a, cap_b], "empty A" => [0, b], "empty B" => [a, 0],
      "pour A->B" => [a - pour_ab, b + pour_ab], "pour B->A" => [a + pour_ba, b - pour_ba]
    }
    nexts.each do |action, s|
      next if prev.key?(s)
      prev[s] = [state, action]
      queue << s
    end
  end
  nil
end

def path(prev, state)
  steps = []
  while prev[state]
    before, action = prev[state]
    steps.unshift("#{action.ljust(10)} -> #{state.inspect}")
    state = before
  end
  steps
end

[[3, 5, 4], [4, 9, 6], [2, 6, 5]].each do |a, b, goal|
  steps = jugs(a, b, goal)
  puts "jugs #{a} and #{b}, goal #{goal}: #{steps ? "#{steps.size} steps" : 'impossible'}"
  steps&.each { |s| puts "  #{s}" }
end
